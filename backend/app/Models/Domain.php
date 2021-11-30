<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\HasRatingsScope;

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
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = ['likes', 'is_certified'];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = ['interactiveDomain', 'trustedDomain'];

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

    public function getLikesAttribute() {
        if(is_null($this->interactiveDomain)) {
            $this->interactiveDomain()->create();
            return 0;
        }
        return $this->interactiveDomain->likes_dislikes_difference;
    }

    public function getIsCertifiedAttribute() {
        if(is_null($this->trustedDomain)) {
            $this->trustedDomain()->create();
            return 0;
        }
        return intval($this->trustedDomain->domainRank > 0);
    }

    public function getRankAttribute() {
        if(is_null($this->trustedDomain)) {
            $this->trustedDomain()->create();
            return 0;
        }
        return $this->trustedDomain->domainRank;
    }
}
