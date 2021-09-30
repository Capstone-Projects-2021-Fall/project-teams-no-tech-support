<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;
use Illuminate\Support\Facades\DB;

class DatabaseTest extends TestCase
{
    /**
     * A basic test checking for a valid database containing tables
     *
     * @return void
     */
    public function test_connection()
    {
        $this->assertNotEmpty(DB::select("SHOW TABLES"), "Failed to connect to a database containing tables");
    }
}
