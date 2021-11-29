<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\HasRatingsScope;

class Domain extends Model
{
    use HasFactory;
    use HasRatingsScope;

    /**
     * The table associated with the Domain model.
     *
     * @var string
     */
    protected $table = 'Domains';
    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];

    /**
     * The "booted" method of the Domain model.
     *
     * @return void
     */
    protected static function booted()
    {
        static::created(function($domain) {
            $domain->trustedDomain()->create();
            $domain->interactiveDomain()->create();
        });
    }

    public function trustedDomain() {
        return $this->hasOne(TrustedDomain::class, 'domain_id');
    }

    public function interactiveDomain() {
        return $this->hasOne(InteractiveDomain::class, 'domain_id');
    }
}
