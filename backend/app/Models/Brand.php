<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Brand extends Model
{
    use HasFactory;

    protected $table = 'Brand';
    public $timestamps = false;

    public function device () {
        return $this->hasOne(Device::class, 'id');
    }

    public function models () {
        return $this->hasMany(DeviceModel::class, 'brand_id');
    }
}
