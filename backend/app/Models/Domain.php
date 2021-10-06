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
    protected $table = 'Domain';
    public $timestamps = false;

    public function domain() {
        return $this->hasMany(Brand::class, 'device_id');  //TODO
    }
}

