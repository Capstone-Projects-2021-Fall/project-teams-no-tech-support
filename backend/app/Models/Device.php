<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\HasNameLikeScope;

class Device extends Model
{
    use HasFactory;
    use HasNameLikeScope;

    /**
     * The table associated with the Device model.
     *
     * @var string
     */
    protected $table = 'Device';
    public $timestamps = false;

    public function brands() {
        return $this->hasMany(Brand::class, 'device_id');
    }
}
