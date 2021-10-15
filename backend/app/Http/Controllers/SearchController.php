<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Http\Client\Response as HttpResponse;
use Illuminate\Http\JsonResponse as HttpJSONResponse;
use Illuminate\Database\Eloquent\Factories\Sequence;

use App\Models\Domain;

/**
 * Controller class which handles all operations related to performing searches and ingesting the new domains
 */
class SearchController extends Controller
{
    /**
     * Query the search API and retrieve results 
     * 
     * TODO: Verify filter functionality (Bing does not seem to respect responseFilter)
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
    private function sortResults(array $results) : array {
        //  TODO: Implement result sorting
    }

    /**
     * Store domains from search results in the database 
     * 
     * TODO: Implement domain storage, improve repetitive code
     * 
     * @param array $results
     * @return void
     */
    private function storeDomains(array $results) : void {
        $domains = array();

        if(array_key_exists('webPages', $results)) {
            foreach($results['webPages']['value'] as $value) {
                $domains[] = $this->parseDomain($value['url']);
            }
        }
        if(array_key_exists('videos', $results)) {
            foreach($results['videos']['value'] as $value) {
                $domains[] = $this->parseDomain($value['contentUrl']);
            }
        }
        if(array_key_exists('images', $results)) {
            foreach($results['images']['value'] as $value) {
                $domains[] = $this->parseDomain($value['contentUrl']);
            }
        }

        $newDomains = $this->checkDomains($domains);

        foreach($newDomains as $newDomain) {
            Domain::create(['name' => $newDomain]);
        }
    }

    /**
     * Handle the sorting and handling of search results and domains 
     * 
     * @param Request $request (String $query)
     * @return HttpJSONResponse
     */
    public function getResults(Request $request) : HttpJSONResponse {
        $query = $request->input('query');  

        $results = $this->search($query)->json();

        $this->storeDomains($results);

        //$sorted = $this->sortResults($results);

        return response()->json($results);
    }

    /**
     * Query the related search API and retrieve results
     * 
     * @param Request $request (String $query)
     * @return HttpJSONResponse
     */
    public function getRelatedQueries(Request $request) : HttpJSONResponse {
        
        $bingKey = config('services.bing_search.key');  //  Retrieve Bing API key
        $searchEndpoint = config('constants.bing.base') . config('constants.bing.search');  //  Retrieve Bing endpoint constants

        $query = $request->input('query');

        $filters = 'RelatedSearches';

        $response = Http::withHeaders([ //  Send basic get request
            'Ocp-Apim-Subscription-Key' => $bingKey,
            'Pragma' => 'no-cache'
        ])->get($searchEndpoint, [
            'q' => urlencode($query),
            'responseFilter' => $filters,
            'count' => 50,  //  Max count is 50
        ]);

        $results = $response->json()['relatedSearches']['value'];

        return response()->json($results);
    }

    /**
     * Helper function to remove uneeded parts of the content URL
     * 
     * @param String $url
     * @return String
     */
    private function parseDomain(String $url) : String {
        $domain = parse_url($url, PHP_URL_HOST);
        $domain = str_replace('www.', '', $domain);
        return $domain;
    }

    /**
     * Determine which domains need to be added to the database 
     * 
     * @param array $domains
     * @return array
     */
    private function checkDomains(array $domains) : array {
        $domains = array_unique($domains, SORT_STRING);
        $presentDoms = Domain::whereIn('name', $domains)->pluck('name')->all();
        $newDoms = array_diff($domains, $presentDoms);
        return $newDoms;
    }
}
