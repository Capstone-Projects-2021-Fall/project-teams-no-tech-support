<?php

namespace Tests\Unit;

use Tests\TestCase;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Testing\Fluent\AssertableJson;
use App\Models\Domain;

/**
 * Tests DomainController::rateDomain() by sending requests to the /rate route
 */
class RateDomainTest extends TestCase
{
    /**
     * Sends a request to the /rate route with null input
     * Tests error handling
     * 
     * @return void
     */
    public function test_nullInput()
    {
        Domain::factory()->create();

        $response = $this->json('GET','/rate');

        $response->assertSuccessful();
    }

    /**
     * Sends a request to the /rate route with a domain name not present in the database
     * Tests error handling
     * 
     * @return void
     */
    public function test_invalidDomain()
    {
        $newDomain = Domain::factory()->create([
            'name' => 'somedomain.com',
        ]);

        $response = $this->json('GET','/rate', ['domain' => 'notdomain.net', 'like' => true]);

        $response->assertSuccessful();

        $updatedLikes = Domain::where('name', $newDomain->name)->first()->likes;

        $this->assertEquals(0, $updatedLikes);
    }

    /**
     * Sends a request to the /rate route a valid domain name and true like status
     * Tests for successful positive rating ability
     * 
     * @return void
     */
    public function test_ratePositive()
    {
        $newDomain = Domain::factory()->liked()->create();

        $response = $this->json('GET','/rate', ['domain' => $newDomain->name, 'like' => true]);

        $response->assertSuccessful();

        $updatedLikes = Domain::where('name', $newDomain->name)->first()->likes;

        $this->assertEquals($newDomain->likes+1, $updatedLikes);
    }

    /**
     * Sends a request to the /rate route a valid domain name and false like status
     * Tests for successful negative rating ability
     * 
     * @return void
     */
    public function test_rateNegative()
    {
        $newDomain = Domain::factory()->disliked()->create();

        $response = $this->json('GET','/rate', ['domain' => $newDomain->name, 'like' => false]);

        $response->assertSuccessful();

        $updatedLikes = Domain::where('name', $newDomain->name)->first()->likes;

        $this->assertEquals($newDomain->likes-1, $updatedLikes);
    }
}
