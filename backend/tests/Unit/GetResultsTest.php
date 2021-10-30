<?php

namespace Tests\Unit;

use Tests\TestCase;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Testing\Fluent\AssertableJson;
use Illuminate\Support\Facades\Http;

use App\Models\Domain;

/**
 * Tests SearchController::getResults() by sending requests to the /results route
 */
class GetResultsTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Sends a request to the /results route with no input parameters
     * Tests handling of null input
     * 
     * @return void
     */
    public function test_nullInputResponse()
    {
        $response = $this->json('GET','/results');

        $response->assertSuccessful()->assertJsonCount(0, $key = null);
    }

    /**
     * Sends a request to the /results route with a valid query
     * Tests ability to return valid JSON and connect to the search API
     * 
     * @return void
     */
    public function test_validInputResponse()
    {
        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->whereType('webPages', 'array')
        );
    }

    /**
     * Sends a request to the /results route with a valid query and checks for a specific domain
     * Tests ability to ingest domains from search results
     * 
     * @return void
     */
    public function test_storeDomains()
    {
        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchSingleSimple.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful();

        $this->assertNotNull(Domain::where('name', 'walmart.com')->first());
    }

    /**
     * Sends a request to the /results route with a valid query and attempts to add an already present domain
     * Tests ability to check which domains should be added and prevent duplicates
     * 
     * @return void
     */
    public function test_checkDomains()
    {
        Domain::factory()->create([
            'name' => 'walmart.com'
        ]);

        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchSingleSimple.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful();

        $this->assertEquals(1, Domain::count());
    }

    /**
     * Sends a request to the /results route with a valid query and attempts to add an already present domain
     * Tests ability to check which domains should be added and prevent duplicates
     * 
     * @return void
     */
    public function test_parseDomainWww()
    {
        Domain::factory()->create([
            'name' => 'walmart.com'
        ]);

        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchSingleSimpleWWW.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful();

        $this->assertEquals(1, Domain::count());
    }

    /**
     * Sends a request to the /results route with a valid query and attempts to add an already present domain
     * Tests ability to check which domains should be added and prevent duplicates
     * 
     * @return void
     */
    public function test_parseDomainWithSubdomain()
    {
        Domain::factory()->create([
            'name' => 'walmart.com'
        ]);

        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchSingleSimpleSubdomain.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful();

        $this->assertNotNull(Domain::where('name', 'subdomain.walmart.com')->first());
    }

    /**
     * Sends a request to the /results route with a valid query and checks for a specific simplified domain
     * Tests ability to parse and simplify domain names
     * 
     * @return void
     */
    public function test_parseDomainFull()
    {
        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchSingle.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful();

        $this->assertNotNull(Domain::where('name', 'walmart.com')->first());
    }

    /**
     * Sends a request to the /results route with a valid query and ensures malformed domains are not stored
     * Tests ability to filter out malformed domains
     * 
     * @return void
     */
    public function test_parseDomainMalformed()
    {
        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchSingleMalformed.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful();

        $this->assertEquals(0, Domain::count());
    }

    /**
     * Sends a request to the /results and attempt to sort seeded domains by likes
     * Tests ability to sort domains by number of likes
     * 
     * @return void
     */
    public function test_sortDomainsByRating()
    {
        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchTen.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        Domain::factory()->create([
            'name' => 'amazon.com',
            'likes' => 1
        ]);
        Domain::factory()->create([
            'name' => 'bestbuy.com',
            'likes' => 20
        ]);
        Domain::factory()->create([
            'name' => 'walmart.com',
            'likes' => 300
        ]);
        Domain::factory()->create([
            'name' => 'computerhope.com',
            'likes' => 400
        ]);
        Domain::factory()->create([
            'name' => 'britannica.com',
            'likes' => 500
        ]);
        Domain::factory()->create([
            'name' => 'perkasiepcrepair.com',
            'likes' => 600
        ]);
        Domain::factory()->create([
            'name' => 'microcenter.com',
            'likes' => 700
        ]);
        Domain::factory()->create([
            'name' => 'angi.com',
            'likes' => 800
        ]);
        Domain::factory()->create([
            'name' => 'penncomputer.com',
            'likes' => 900
        ]);
        Domain::factory()->create([
            'name' => 'manta.com',
            'likes' => 1000
        ]);

        $this->assertEquals(10, Domain::count());

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages', 10)
                ->has('webPages.0', fn ($json) => $json->where('baseDomain', 'manta.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.1', fn ($json) => $json->where('baseDomain', 'penncomputer.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.2', fn ($json) => $json->where('baseDomain', 'angi.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.3', fn ($json) => $json->where('baseDomain', 'microcenter.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.4', fn ($json) => $json->where('baseDomain', 'perkasiepcrepair.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.5', fn ($json) => $json->where('baseDomain', 'britannica.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.6', fn ($json) => $json->where('baseDomain', 'computerhope.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.7', fn ($json) => $json->where('baseDomain', 'walmart.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.8', fn ($json) => $json->where('baseDomain', 'bestbuy.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.9', fn ($json) => $json->where('baseDomain', 'amazon.com')->etc())
        );
    }

    /**
     * Sends a request to the /results and attempt to sort seeded domains by likes and certification status
     * Tests ability to sort domains when certification status is utilized
     * 
     * @return void
     */
    public function test_sortDomainsByRatingAndCerficiation()
    {
        $fakeResponse = file_get_contents(base_path().'/tests/Unit/responses/searchTen.txt');

        Http::fake([
            '*' => Http::response($fakeResponse, 200),
        ]);

        Domain::factory()->certified()->create([
            'name' => 'amazon.com',
            'likes' => 1
        ]);
        Domain::factory()->create([
            'name' => 'bestbuy.com',
            'likes' => 20
        ]);

        $this->assertEquals(2, Domain::count());

        $response = $this->json('GET','/results', ['query' => 'Dell XPS 13 slow wifi']);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages', 10)
                ->has('webPages.0', fn ($json) => $json->where('baseDomain', 'amazon.com')->etc())
        )->assertJson(fn (AssertableJson $json) =>
            $json->has('webPages.1', fn ($json) => $json->where('baseDomain', 'bestbuy.com')->etc())
        );
    }
}
