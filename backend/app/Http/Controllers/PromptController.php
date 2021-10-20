<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\JsonResponse as HttpJSONResponse;

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
        $input = $request->input('input');
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
            if(strlen($hint) > 0) { //  Check for hint (brand name)
                $brand = Brand::where('name', $hint)->first();
            }

            if(!is_null($brand)) {  //  Check brand name hint validity
                $suggestions = $brand->models()->nameLike($input)->get();
            } else {    //  Fallback (ignore hint)
                $suggestions = DeviceModel::nameLike($input)->get();    
            }
        } else {    //
            $suggestions = $this->getSearchSuggestions($input);
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
            'q' => urlencode($input),
        ]);

        $results = $response->json()['suggestionGroups'][0]['searchSuggestions'];

        $queries = array();

        foreach($results as $result) {
            $queries[] = $result['query'];
        }

        return $queries;
    }
}
