<?php

namespace Database\Factories;

use App\Models\Brand;
use App\Models\Device;

use Illuminate\Database\Eloquent\Factories\Factory;

class BrandFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Brand::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->domainWord(),
            'device_id' => function (array $attributes) { 
                return array_rand(Device::pluck('id')->all(), 1); 
            },
            'tech_support_number' => $this->faker->numerify('##########')
        ];
    }
}
