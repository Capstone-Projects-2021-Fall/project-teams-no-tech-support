<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

/**
 * Controller class which handles all operations specific to Domain objects
 */
class DomainController extends Controller
{
    /**
     * Retrieve domain rating information from the database and return it
     * 
     * @param String $domain
     * @return array
     */
    public function getRating(String $domain) : array {
        //  TODO: Implement method
    }

    /**
     * Allow users to rate domains and update the rating in the database 
     * 
     * @param String $domain
     * @param boolean $like
     * @return void
     */
    public function rateDomain(String $domain, boolean $like) : void {
        //  TODO: Implement method
    }
}
