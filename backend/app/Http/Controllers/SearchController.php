<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Client\Response as HttpResponse;
use Illuminate\Http\JsonResponse as HttpJSONResponse;

/**
 * Controller class which handles all operations related to performing searches and ingesting the new domains
 */
class SearchController extends Controller
{
    /**
     * Query the search API and retrieve results 
     * 
     * @param String $query
     * @return HttpResponse
     */
    private function search(String $query) : HttpResponse {
        $bingKey = config('services.bing_search.key');  //  Retrieve Bing API key
        $searchEndpoint = config('constants.bing.base') . config('constants.bing.search');  //  Retrieve Bing endpoint constants

        $filters = ['Images','Webpages','Videos'];

        $response = Http::withHeaders([ //  Send basic get request
            'Ocp-Apim-Subscription-Key' => $bingKey,
            'Pragma' => 'no-cache'
        ])->get($searchEndpoint, [
            'q' => urlencode($query),
            'responseFilter' => $filters,
            'count' => 50,  //  Max count is 50
        ]);

        return $response;
    }

    /**
     * Handle the sorting and handling of search results and domains 
     * 
     * @param String $query
     * @return HttpJSONResponse
     */
    private function sortResults(array $results) : array{
        //  TODO: Implement result sorting
    }

    /**
     * Store domains from search results in the database 
     * 
     * @param array $results
     * @return void
     */
    private function storeDomains(array $results) : void {
        //  TODO: Implement domain storage
    }

    /**
     * Handle the sorting and handling of search results and domains 
     * 
     * @param String $query
     * @return HttpJSONResponse
     */
    public function getResults(Request $request) : HttpJSONResponse {
        $query = $request->input('query');  

        $results = $this->search($query)->collect();

        return response()->json($results);
    }

    /**
     * Query the related search API and retrieve results
     * 
     * @param String $query
     * @return array
     */
    public function getRelatedQueries(String $query) : array {
        $bingKey = config('services.bing_search.key');
    }
}
