<?php

namespace Database\Factories;

use App\Models\DeviceModel;
use App\Models\Brand;

use Illuminate\Database\Eloquent\Factories\Factory;

class DeviceModelFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = DeviceModel::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'brand_id' => function (array $attributes) { 
                $brand_ids = Brand::pluck('id')->all();
                return $brand_ids[array_rand($brand_ids, 1)]; 
            },
            'name' => $this->faker->word().' '.strtoupper($this->faker->randomLetter()).$this->faker->randomNumber(2, false),
            'year' => $this->faker->numberBetween(2005, 2021),
        ];
    }
}
