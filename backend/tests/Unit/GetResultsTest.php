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
            $json->whereType('webPages', 'array')->etc()
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

        $amazon = Domain::factory()->create(['name' => 'amazon.com']);
        $amazon->interactiveDomain->likes_dislikes_difference = 1;
        $amazon->push();

        $bestbuy = Domain::factory()->create(['name' => 'bestbuy.com']);
        $bestbuy->interactiveDomain->likes_dislikes_difference = 20;
        $bestbuy->push();

        $walmart = Domain::factory()->create(['name' => 'walmart.com']);
        $walmart->interactiveDomain->likes_dislikes_difference = 300;
        $walmart->push();
        
        $computerHope = Domain::factory()->create(['name' => 'computerhope.com']);
        $computerHope->interactiveDomain->likes_dislikes_difference = 400;
        $computerHope->push();

        $britannica = Domain::factory()->create(['name' => 'britannica.com']);
        $britannica->interactiveDomain->likes_dislikes_difference = 500;
        $britannica->push();

        $perkasiePCRepair = Domain::factory()->create(['name' => 'perkasiepcrepair.com']);
        $perkasiePCRepair->interactiveDomain->likes_dislikes_difference = 600;
        $perkasiePCRepair->push();

        $microcenter = Domain::factory()->create(['name' => 'microcenter.com']);
        $microcenter->interactiveDomain->likes_dislikes_difference = 700;
        $microcenter->push();

        $angi = Domain::factory()->create(['name' => 'angi.com']);
        $angi->interactiveDomain->likes_dislikes_difference = 800;
        $angi->push();

        $penncomputer = Domain::factory()->create(['name' => 'penncomputer.com']);
        $penncomputer->interactiveDomain->likes_dislikes_difference = 900;
        $penncomputer->push();

        $manta = Domain::factory()->create(['name' => 'manta.com']);
        $manta->interactiveDomain->likes_dislikes_difference = 1000;
        $manta->push();

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

        $certDom = Domain::factory()->create(['name' => 'amazon.com']);
        $certDom->trustedDomain->domainRank = 1;
        $certDom->interactiveDomain->likes_dislikes_difference = 1;
        $certDom->push();
        
        $uncertDom = Domain::factory()->create(['name' => 'bestbuy.com']);
        $uncertDom->interactiveDomain->likes_dislikes_difference = 20;
        $uncertDom->push();

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
