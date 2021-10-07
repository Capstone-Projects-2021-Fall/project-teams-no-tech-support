<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DomainSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('Domains')->insert([
            'name' => str_random(45),
            'is_certified' => 1,
            'likes' => rand(0, 999),
        ]);
    }
}
