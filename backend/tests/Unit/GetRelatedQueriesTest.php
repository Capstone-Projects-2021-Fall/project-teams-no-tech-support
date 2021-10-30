<?php

namespace Tests\Unit;

use Tests\TestCase;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Testing\Fluent\AssertableJson;
use Illuminate\Support\Facades\Http;

/**
 * Tests SearchController::getRelatedQueries() by sending requests to the /related route
 */
class GetRelatedQueriesTest extends TestCase
{
    /**
     * Sends a request to the /related route with no input parameters
     * Tests handling of null input
     * 
     * @return void
     */
    public function test_nullInputResponse()
    {
        $response = $this->json('GET','/related');

        $response->assertSuccessful()->assertJsonCount(0, $key = null);
    }

    /**
     * Sends a request to the /related route with valid input parameters
     * Tests for expected response to valid input
     * 
     * @return void
     */
    public function test_validInputResponse()
    {
        $response = $this->json('GET','/related', ['query' => 'Comput']);

        $response->assertSuccessful()->assertJsonStructure([
            '*' => [
                'text',
                'displayText',
                'webSearchUrl',
            ]
        ]);
    }
}
