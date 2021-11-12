<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\JsonResponse as HttpJSONResponse;

use Google\Cloud\Language\LanguageClient;

use App\Models\Device;
use App\Models\Brand;
use App\Models\DeviceModel;

/**
 * Controller class which handles all operations related to creating prompts on the front-end
 */
class PromptController extends Controller
{
    /**
     * Provide a list of input suggestions based on provided input. 
     * If the prompt is in the database, retrieve local suggestions. 
     * If the prompt is not in the database, utilize the method in SearchController of the same name.
     * 
     * @param Request $request (String $input, String $prompt = '', String $hint = '')
     * @return HttpJSONResponse
     */
    public function getSuggestions(Request $request) : HttpJSONResponse {
        $input = $request->input('input', '');
        $prompt = $request->input('prompt', '');
        $hint = $request->input('hint', '');    //  Device name (for brand) or brand name (for model)
        $suggestions = NULL;

        if(strcasecmp($prompt, "device") == 0) {
            $suggestions = Device::nameLike($input)->get();
        } elseif(strcasecmp($prompt, "brand") == 0) {
            $device = NULL;
            if(strlen($hint) > 0) { //  Check for hint (device name)
                $device = Device::where('name', $hint)->first();
            }

            if(!is_null($device)) { //  Check device name hint validity
                $suggestions = $device->brands()->nameLike($input)->get();
            } else {    //  Fallback (ignore hint)
                $suggestions = Brand::nameLike($input)->get();  
            }
        } elseif(strcasecmp($prompt, "model") == 0) {
            $brand = NULL;
            if(strlen($hint) > 0) { //  Check for hint (brand name and device type)
                $hints = explode('|', $hint);

                if(count($hints) == 2) {
                    $device = Device::where('name', $hints[1])->select('id')->first();
                    $brand = Brand::where('name', $hints[0])->where('device_id', $device->id)->first();
                } else {
                    $brand = Brand::where('name', $hint)->first();  //  TODO: Remove this functionality (Require both parts of the hint for model prompt)
                }
            }

            if(!is_null($brand)) {  //  Check brand name hint validity
                $suggestions = $brand->models()->nameLike($input)->get();
            } else {    //  Fallback (ignore hint)
                $suggestions = DeviceModel::nameLike($input)->get();    
            }
        } else {
            if(strlen($input) > 0) {
                $suggestions = $this->getSearchSuggestions($input);
            }
        }

        return response()->json($suggestions);
    }

    /**
     * getSearchSuggestions
     * 
     * @param String $input
     * @return array
     */
    public function getSearchSuggestions(String $input) : array {
        $bingKey = config('services.bing_search.key');
        $searchEndpoint = config('constants.bing.base') . config('constants.bing.autosuggest');  //  Retrieve Bing endpoint constants

        $response = Http::withHeaders([ //  Send basic get request
            'Ocp-Apim-Subscription-Key' => $bingKey,
            'Pragma' => 'no-cache'
        ])->get($searchEndpoint, [
            'q' => $input,
        ]);

        if($response->successful()) {
            $results = $response->json()['suggestionGroups'][0]['searchSuggestions'];

            $queries = array();
    
            foreach($results as $result) {
                $queries[] = $result['query'];
            }
    
            return $queries;
        } else {
            $errorType = '(server)';
            if($response->clientError()) {
                $errorType = '(client)';
            }
            
            return ['error' => 'Search API returned error '.$errorType];
        }
    }

    /**
     * Extract key phrases and categorize them using Azure Cognitive language API 
     * 
     * @param Request $request (String $query)
     * @return HttpJSONResponse
     */
    public function extractPhrases(Request $request) : HttpJSONResponse {
        $azureKey = config('services.azure_cognitive.key');  //  Retrieve Azure API key
        $phrasesEndpoint = config('constants.azureCognitive.base') . config('constants.azureCognitive.keyPhrases');  //  Retrieve Azure endpoint constants

        $query = $request->input('query', '');

        if(strlen($query) > 0) {
            $body = '{ documents: [{ id: "1", language:"en", text: "'.$query.'"}]}';

            $response = Http::withHeaders([ //  Send basic get request
                'Ocp-Apim-Subscription-Key' => $azureKey
            ])->withBody($body, 'application/json')->post($phrasesEndpoint);

            return response()->json($response->json()['documents'][0]['keyPhrases']);
        }

        return response()->json(['error' => 'Azure Cognitive error']);
    }

    public function extractSyntax(Request $request) : HttpJSONResponse {
        $query = $request->input('query', '');

        $query = "my computer will not turn on aspire 3000";

        $config = [
            'keyFilePath' => config('services.google_cloud.credentials'),
        ];

        $client = new LanguageClient($config);

        $annotated = $client->analyzeSyntax($query);
        $tokens = $annotated->tokens();
        $sentence = $annotated->sentences()[0]['text']['content'];

        $device = Device::whereRaw('"'.$sentence. '" LIKE CONCAT("%", name, "%")')->first();
        $brand = Brand::whereRaw('"'.$sentence. '" LIKE CONCAT("%", name, "%")')->first();
        $model = DeviceModel::whereRaw('"'.$sentence. '" LIKE CONCAT("%", name, "%")')->first();

        $revisedSentence = preg_replace('/\s+/', ' ', $sentence);

        if(!is_null($model)) {  //  Pull model name from text if possible
            $model = $model->name;
            
            $revisedSentence = str_ireplace($model, $model, $revisedSentence);
        }

        if(!is_null($brand)) {  //  Pull brand name from text if possible
            $brand = $brand->name;
            $revisedSentence = str_ireplace($brand, $brand, $revisedSentence);
        } elseif(!is_null($model)) {    //  Determine brand name from model
            $brand = DeviceModel::where('name', $model)->first()->brand->name;
        }

        if(!is_null($device)) { //  Pull device type from text if possible
            $device = $device->name;
        } elseif(!is_null($model)) {    //  Determine device type from model (brand alone is not necessarily accurate)
            $brandObj = DeviceModel::where('name', $model)->first()->brand;
            $device = $brandObj->device->name;
        }

        if(!is_null($device)) {
            if(!is_null($brand)) {
                $revisedSentence = str_ireplace($brand, '', $revisedSentence);

                if(!is_null($model)) {
                    $revisedSentence = str_ireplace($model, '', $revisedSentence);
                    $revisedSentence = str_ireplace($device, $brand . ' ' . $model, $revisedSentence);
                } else {
                    $revisedSentence = str_ireplace($device, $brand . ' ' . $device, $revisedSentence);
                }
            }
        }

        $revisedSentence = str_ireplace($device, '', $revisedSentence);

        $revisedSentence = preg_replace('/\s+/', ' ', $revisedSentence);
    }
}
