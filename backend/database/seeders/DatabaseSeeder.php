<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            DeviceSeeder::class,
            BrandSeeder::class,
            DeviceModelSeeder::class,
            DomainSeeder::class,
        ]);
    }
}
