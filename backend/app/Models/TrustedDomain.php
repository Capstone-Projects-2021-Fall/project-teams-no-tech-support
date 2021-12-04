<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrustedDomain extends Model
{
    use HasFactory;

    /**
     * The table associated with the InteractiveDomain model.
     *
     * @var string
     */
    protected $table = 'TrustedDomains';
    public $timestamps = false;

    /**
     * The TrustedDomain model's default values for attributes.
     *
     * @var array
     */
    protected $attributes = [
        'domainRank' => 0,
    ];

    public function domain() {
        return $this->belongsTo(Domain::class);
    }
}

