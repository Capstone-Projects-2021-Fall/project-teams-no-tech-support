<?php

namespace Tests\Unit;

use Tests\TestCase;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Testing\Fluent\AssertableJson;
use App\Models\Domain;

/**
 * Tests DomainController::getRating() by sending requests to the /domain route
 */
class GetRatingTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Sends a request to the /domain route with null input
     * Tests error handling
     * 
     * @return void
     */
    public function test_nullInput()
    {
        Domain::factory()->create();

        $response = $this->json('GET','/domain');

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->whereType('error', 'string')
        );
    }

    /**
     * Sends a request to the /domain route with a domain name not present in the database
     * Tests error handling
     * 
     * @return void
     */
    public function test_invalidDomain()
    {
        Domain::factory()->create([
            'name' => 'somedomain.com',
        ]);

        $response = $this->json('GET','/domain', ['domain' => 'notdomain.net']);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->whereType('error', 'string')
        );
    }

    /**
     * Sends a request to the /domain route with the name of a valid and complete domain entry
     * Tests a successful retrieval of domain rating information and certification status distinction
     * 
     * @return void
     */
    public function test_uncertifiedDomain()
    {
        $newDomain = Domain::factory()->liked()->create();

        $response = $this->json('GET','/domain', ['domain' => $newDomain->name]);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->where('rating', $newDomain->likes)
                ->where('is_certified', $newDomain->is_certified)
        );
    }

    /**
     * Sends a request to the /domain route with the name of a valid and complete domain entry
     * Tests a successful retrieval of domain rating information and certification status distinction
     * 
     * @return void
     */
    public function test_certifiedDomain()
    {
        $newDomain = Domain::factory()->certified()->create();

        $response = $this->json('GET','/domain', ['domain' => $newDomain->name]);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->where('rating', $newDomain->likes)
                ->where('is_certified', $newDomain->is_certified)
        );
    }
}
