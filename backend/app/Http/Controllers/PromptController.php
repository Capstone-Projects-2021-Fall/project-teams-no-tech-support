<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\JsonResponse as HttpJSONResponse;

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
     * @param Reqiest $request (String $input, String $prompt)
     * @return HttpJSONResponse
     */
    public function getSuggestions(Request $request) : HttpJSONResponse {
        $input = $request->input('input');
        $prompt = $request->input('prompt', '');
        $hint = $request->input('hint', '');    //  Device name (for brand) or brand name (for model)
        $suggestions = NULL;

        if(strcasecmp($prompt, "device") == 0) {
            //  TODO: Check for device suggestions with Device model
        } elseif(strcasecmp($prompt, "brand") == 0) {
            //  TODO: Check for brand suggestions with Brand model
        } elseif(strcasecmp($prompt, "model") == 0) {
            //  TODO: Check for model suggestions with Model model
        } else {
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
