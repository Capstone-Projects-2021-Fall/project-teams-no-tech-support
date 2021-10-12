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

}

