<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DeviceModelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('Model')->insert([
            'name' => str_random(10),
            'year' => '2021',
        ]);
    }
}
