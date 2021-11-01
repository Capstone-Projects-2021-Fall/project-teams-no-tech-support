<?php

namespace Tests\Unit;

use Tests\TestCase;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Testing\Fluent\AssertableJson;
use App\Models\Brand;

/**
 * Tests PromptController::getSuggestions() by sending requests to the /suggestions route
 */
class GetSuggestionsTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Sends a request to the /suggestions route with no input parameters
     * Tests handling of null input
     * 
     * @return void
     */
    public function test_nullInput()
    {
        $response = $this->json('GET','/suggestions');

        $response->assertSuccessful()->assertJsonCount(0, $key = null);
    }

    /**
     * Sends a request to the /suggestions route with null input but valid prompt
     * Tests handling of null input with a valid prompt
     * 
     * @return void
     */
    public function test_nullInputValidPrompt()
    {
        Brand::factory()->count(10)->create();

        $response = $this->json('GET','/suggestions', ['prompt' => 'brand']);

        $response->assertSuccessful()->assertJsonCount(10, $key = null);
    }

    /**
     * Sends a request to the /suggestions route with null input and an invalid prompt
     * Tests handling of null input with an invalid prompt
     * 
     * @return void
     */
    public function test_nullInputInvalidPrompt()
    {
        Brand::factory()->count(10)->create();

        $response = $this->json('GET','/suggestions', ['prompt' => 'unknown']);

        $response->assertSuccessful()->assertJsonCount(0, $key = null);
    }

    /**
     * Sends a request to the /suggestions route with partial input and an valid prompt
     * Tests handling of valid input/prompt combinations
     * 
     * @return void
     */
    public function test_validInputValidPrompt()
    {
        Brand::factory()->count(10)->create();

        Brand::factory()->create([
            'name' => 'Searchable Brand',
        ]);

        $response = $this->json('GET','/suggestions', ['input' => 'Sear', 'prompt' => 'brand']);

        $response->assertSuccessful()->assertJson([['name' => 'Searchable Brand']]);
    }

    /**
     * Sends a request to the /suggestions route with partial input and an valid prompt
     * Tests handling of valid input/prompt combinations
     * 
     * @return void
     */
    public function test_validInputNoPrompt()
    {
        $response = $this->json('GET','/suggestions', ['input' => 'Search']);

        $response->assertSuccessful()->assertJson(['search']);
    }

    /**
     * Sends a request to the /suggestions route with partial input and an valid prompt
     * Tests handling of valid input/prompt combinations
     * 
     * @return void
     */
    public function test_validInputInvalidPrompt()
    {
        $response = $this->json('GET','/suggestions', ['input' => 'Search', 'prompt' => 'unknown']);

        $response->assertSuccessful()->assertJson(['search']);
    }

    //TODO: Add further tests for testing hints (Need to add any new tests to testing document)
}
