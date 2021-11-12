<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\HasNameLikeScope;

class DeviceModel extends Model
{
    use HasFactory;
    use HasNameLikeScope;

    protected $table = 'Model';
    public $timestamps = false;

    public function brand () {
        return $this->belongsTo(Brand::class);
    }
}
