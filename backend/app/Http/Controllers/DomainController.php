<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

/**
 * Controller class which handles all operations related to Domain objects
 */
class DomainController extends Controller
{
    /**
     * Retrieve domain rating information from the database and return it
     * 
     * @param String $domain
     * @return array
     */
    private function getRating(String $domain) : array {
        //  TODO: Implement method
    }

    /**
     * Allow users to rate domains and update the rating in the database 
     * 
     * @param String $domain
     * @param boolean $like
     * @return void
     */
    private function rateDomain(String $domain, boolean $like) : void {
        //  TODO: Implement method
    }

    /**
     * Add a new domain to the database
     * 
     * @param String $domain
     * @return void
     */
    private function addDomain(String $domain) : void {
        //  TODO: Implement method
    }

    /**
     * Determine which domains need to be added to the database 
     * 
     * @param array $domains
     * @return array
     */
    private function checkDomains(array $domains) : array {
        //  TODO: Implement method
    }
}
