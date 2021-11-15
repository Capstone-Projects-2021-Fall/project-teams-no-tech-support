<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\HasNameLikeScope;

class Brand extends Model
{
    use HasFactory;
    use HasNameLikeScope;

    protected $table = 'Brand';
    public $timestamps = false;

    public function device () {
        return $this->belongsTo(Device::class);
    }

    public function models () {
        return $this->hasMany(DeviceModel::class, 'brand_id');
    }
}
