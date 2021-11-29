<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse as HttpJSONResponse;

use App\Models\Domain;

/**
 * Controller class which handles all operations specific to Domain objects
 */
class DomainController extends Controller
{
    /**
     * Retrieve domain rating information from the database and return it
     * 
     * @param Request $request (String $domain)
     * @return HttpJSONResponse ({boolean is_certified, int likes})
     */
    public function getRating(Request $request) : HttpJSONResponse {
        $domainName = $request->input('domain', '');  
        $domain = NULL;
        if(strlen($domainName) > 0) {
            $domain = Domain::where('name', $domainName)->first();
            if(is_null($domain)) {
                return response()->json(['error' => 'Backend API returned error: Domain not found']);
            }
            return response()->json($domain);
        }
        return response()->json(['error' => 'Backend API returned error: Null input']);
    }

    /**
     * Allow users to rate domains and update the rating in the database 
     * 
     * @param Request $request (String $domain, boolean $like)
     * @return void
     */
    public function rateDomain(Request $request) : void {
        $domainName = $request->input('domain', '');
        $like = $request->input('like', true);

        if(strlen($domainName) > 0) {
            if($like) {
                $domain = Domain::where('name', $domainName)->interactiveDomain->increment('likes_dislikes_difference');
            } else {
                $domain = Domain::where('name', $domainName)->interactiveDomain->decrement('likes_dislikes_difference');
            }
        }
    }
}
