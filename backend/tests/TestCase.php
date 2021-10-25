<?php

namespace Tests;

use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Database\Seeders\DeviceSeeder;

abstract class TestCase extends BaseTestCase
{
    use CreatesApplication;

    protected $seeder = DeviceSeeder::class;
}
