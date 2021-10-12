<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Domain;

class DomainSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Domain::factory()->count(5)->create();
        Domain::factory()->count(5)->certified()->create();
        Domain::factory()->count(10)->liked()->create();
        Domain::factory()->count(10)->disliked()->create();
    }
}
