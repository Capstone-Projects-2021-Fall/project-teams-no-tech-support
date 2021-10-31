<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse as HttpJSONResponse;

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
        $domain = $request->input('domain', '');  

        //  TODO: Implement rating retrieval

        return response()->json($domain);
    }

    /**
     * Allow users to rate domains and update the rating in the database 
     * 
     * @param Request $request (String $domain, boolean $like)
     * @return void
     */
    public function rateDomain(Request $request) : void {
        $domain = $request->input('domain', '');
        $like = $request->input('like', true);

        //  TODO: Implement domain rating ability
    }
}
