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
     * @param String $query
     * @return HttpResponse
     */
    private function search(String $query) : HttpResponse {
        $bingKey = config('services.bing_search.key');  //  Retrieve Bing API key
        $searchEndpoint = config('constants.bing.base') .'error'. config('constants.bing.search');  //  Retrieve Bing endpoint constants

        //  NOTE: Use of multiple response filter parameters requires that the commas NOT BE ENCODED
        //  Therefore, we cannot use the built-in parameter structure from GuzzleHttp
        $parameters="?responseFilter=Webpages,Videos,Images&count=50&q=".urlencode($query);

        $response = Http::withHeaders([ //  Send basic get request
            'Ocp-Apim-Subscription-Key' => $bingKey,
            'Pragma' => 'no-cache'
        ])->get($searchEndpoint.$parameters);
        
        return $response;
    }

    /**
     * Handle the sorting and handling of search results and domains 
     * 
     * @param Object $results
     * @return array
     */
    private function sortResults(Object $results) : array {
        $sorted = array();

        foreach($results as $category => $values) {
            $domains = array();

            if(strcmp($category, 'webPages') == 0 || strcmp($category, 'videos') == 0 || strcmp($category, 'images') == 0) {
                $urlProperty = "contentUrl";
                if(strcmp($category, 'webPages') == 0) {
                    $urlProperty = "url";
                }

                foreach($values->value as $value) {
                    $value->baseDomain = $this->parseDomain($value->$urlProperty);
                    $domains[] = $value->baseDomain;
                }

                $baseDomains = Domain::whereIn('name', $domains)->get();

                foreach($values->value as $value) {
                    $domainData = $baseDomains->where('name', $value->baseDomain)->first();
                    $value->domainLikes = $domainData->likes;
                    $value->domainCertified = $domainData->is_certified;
                }

                usort($values->value, function($a, $b) {
                    return ($a->domainLikes + $a->domainCertified * 50) > ($b->domainLikes + $b->domainCertified * 50);   //  Give cerficiation a weight of 50 likes
                });

                $sorted[$category] = $values->value;
            }
        }

        return $sorted;
    }

    /**
     * Store domains from search results in the database 
     * 
     * @param object $results
     * @return void
     */
    private function storeDomains(Object $results) : void {
        $domains = array();

        foreach($results as $category => $values) {
            if(strcmp($category, 'webPages') == 0 || strcmp($category, 'videos') == 0 || strcmp($category, 'images') == 0) {
                $urlProperty = "contentUrl";
                if(strcmp($category, 'webPages') == 0) {
                    $urlProperty = "url";
                }

                foreach($values->value as $value) {
                    $domains[] = $this->parseDomain($value->$urlProperty);
                }
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

        $response = $this->search($query);
        
        if($response->successful()) {
            $results = $response->object();

            $this->storeDomains($results);
    
            $sorted = $this->sortResults($results);
    
            return response()->json($sorted);
        } else {
            $errorType = '(server)';
            if($response->clientError()) {
                $errorType = '(client)';
            } 
            
            return response()->json(['error' => 'Search API returned error '.$errorType]);
        }
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

        if($response->successful()) {
            $results = $response->json()['relatedSearches']['value'];

            return response()->json($results);
        } else {
            $errorType = '(server)';
            if($response->clientError()) {
                $errorType = '(client)';
            }
            
            return response()->json(['error' => 'Search API returned error '.$errorType]);
        }
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
