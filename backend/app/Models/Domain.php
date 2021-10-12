<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Domain extends Model
{
    use HasFactory;

    /**
     * The table associated with the Domain model.
     *
     * @var string
     */
    protected $table = 'Domains';
    public $timestamps = false;

    /**
     * The Domain model's default values for attributes.
     *
     * @var array
     */
    protected $attributes = [
        'is_certified' => false,
        'likes' => 0,
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];

}

