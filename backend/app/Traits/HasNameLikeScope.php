<?php

namespace App\Traits;

/**
 * Trait which adds scope "nameLike" 
 * Provides "nameLike()" function to models for use in automatic suggestions
 */
trait HasNameLikeScope
{
    /**
     * Helper function for use in suggestion-related queries on Device, Brand, and DeviceModel models
     * 
     * TODO: Optimize use of SOUNDEX or replace with better spelling suggestion algorithm (Levenshtein distance?)
     * 
     * @param \Illuminate\Database\Eloquent\Builder $query
     * @param String $input
     */
    public function scopeNameLike($query, $input)
    {
        return $query->where('name', 'like', '%'.$input.'%')->orWhere('name', 'sounds like', $input);
    }
}