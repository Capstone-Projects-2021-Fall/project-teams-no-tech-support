<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class BrandSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('Brand')->insert([
            'tech_support_number' => $faker->numerify('###-###-####'),
        ]);
    }
}
