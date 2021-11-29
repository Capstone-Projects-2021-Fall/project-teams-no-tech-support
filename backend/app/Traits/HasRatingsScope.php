<?php

namespace App\Traits;

trait HasRatingsScope
{
    public function scopeRating($query)
    {
        $baseDomain = $query->first();

        if(!is_null($baseDomain->interactiveDomain)) {
            return $baseDomain->interactiveDomain->likes_dislikes_difference;
        }

        return 0;
    }

    public function scopeRank($query)
    {
        $baseDomain = $query->first();
        
        if(!is_null($baseDomain->trustedDomain)) {
            return $baseDomain->trustedDomain->domainRank;
        }

        return 0;
    }
}