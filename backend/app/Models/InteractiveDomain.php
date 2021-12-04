<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InteractiveDomain extends Model
{
    use HasFactory;

    /**
     * The table associated with the InteractiveDomain model.
     *
     * @var string
     */
    protected $table = 'InteractiveDomains';
    public $timestamps = false;

    /**
     * The InteractiveDomain model's default values for attributes.
     *
     * @var array
     */
    protected $attributes = [
        'likes_dislikes_difference' => 0,
    ];

    public function domain() {
        return $this->belongsTo(Domain::class);
    }
}

