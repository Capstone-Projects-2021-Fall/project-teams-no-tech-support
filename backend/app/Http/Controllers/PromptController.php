<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
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
     * @param String $input
     * @param String $prompt
     * @return array
     */
    public function getSuggestions(Request $request) : HttpJSONResponse {
        $input = $request->input('input');
        $prompt = $request->input('prompt', '');

        if(strcasecmp($prompt, "device")) {
            //  TODO: Check for device suggestions with Device model
        } elseif(strcasecmp($prompt, "brand")) {
            //  TODO: Check for brand suggestions with Brand model
        } elseif(strcasecmp($prompt, "model")) {
            //  TODO: Check for model suggestions with Model model
        } else {
            $suggestions = $this->getSearchSuggestions($input)->json();
        }

        return $suggestions;
    }

    /**
     * Query the related search API and retrieve results
     * 
     * @param String $input
     * @return array
     */
    public function getSearchSuggestions(String $input) : HttpResponse {
        $bingKey = config('services.bing_search.key');

        //  TODO: Implement Bing search suggestions
    }
}
