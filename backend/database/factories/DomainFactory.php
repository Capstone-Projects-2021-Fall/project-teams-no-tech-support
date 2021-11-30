<?php

namespace Database\Factories;

use App\Models\Domain;
use Illuminate\Database\Eloquent\Factories\Factory;

class DomainFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Domain::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->domainName(),
            //'is_certified' => 0,
            //'likes' => 0,
        ];
    }

    /**
     * Indicate that the model's certification state should be true.
     *
     * @return \Illuminate\Database\Eloquent\Factories\Factory
     */
    public function certified()
    {
        return $this->state(function (array $attributes) {
            return [
                'is_certified' => 1,
            ];
        });
    }

    /**
     * Indicate that the model's like count should be positive
     *
     * @return \Illuminate\Database\Eloquent\Factories\Factory
     */
    public function liked()
    {
        return $this->state(function (array $attributes) {
            return [
                'likes' => $this->faker->numberBetween(1, 1000),
            ];
        });
    }

    /**
     * Indicate that the model's like count should be negative
     *
     * @return \Illuminate\Database\Eloquent\Factories\Factory
     */
    public function disliked()
    {
        return $this->state(function (array $attributes) {
            return [
                'likes' => $this->faker->numberBetween(-1000, -1),
            ];
        });
    }
}
