<?php

namespace Tests\Unit;

use Tests\TestCase;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Testing\Fluent\AssertableJson;
use App\Models\Brand;

/**
 * Tests BrandController::getBrandInfo() by sending requests to the /brand route
 */
class GetBrandInfoTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Sends a request to the /brand route with null input
     * Tests error handling
     * 
     * @return void
     */
    public function test_nullInput()
    {
        Brand::factory()->create();

        $response = $this->withHeaders([
            'X-Header' => 'Value',
        ])->get('/brand');

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->whereType('error', 'string')
        );
    }

    /**
     * Sends a request to the /brand route with a brand name not present in the database
     * Tests error handling
     * 
     * @return void
     */
    public function test_invalidBrand()
    {
        Brand::factory()->create([
            'name' => 'SomeBrand',
        ]);

        $response = $this->json('GET','/brand', ['brand' => 'NotBrand']);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->whereType('error', 'string')
        );
    }

    /**
     * Sends a request to the /brand route with a brand name present in the database but missing a phone number
     * Tests error handling
     * 
     * @return void
     */
    public function test_noPhoneForBrand()
    {
        $newBrand = Brand::factory()->create([
            'tech_support_number' => '',
        ]);

        $response = $this->json('GET','/brand', ['brand' => $newBrand->name]);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->whereType('error', 'string')
        );
    }

    /**
     * Sends a request to the /brand route with the name of a valid and complete brand entry
     * Tests a successful retrieval
     * 
     * @return void
     */
    public function test_canRetrievePhone()
    {
        $newBrand = Brand::factory()->create();

        $response = $this->json('GET','/brand', ['brand' => $newBrand->name]);

        $response->assertSuccessful()->assertJson(fn (AssertableJson $json) =>
            $json->where('phone', $newBrand->tech_support_number)
        );
    }
}
