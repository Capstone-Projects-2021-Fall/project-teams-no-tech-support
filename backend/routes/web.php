<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SearchController;
use App\Http\Controllers\DomainController;
use App\Http\Controllers\BrandController;
use App\Http\Controllers\PromptController;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/test1', function () {
    return view('test1');
});

//  Search-specific routes
Route::get('/results', [SearchController::class, 'getResults']);
Route::get('/related', [SearchController::class, 'getRelatedQueries']);


//  Domain-specific routes
Route::get('/rate', [DomainController::class, 'rateDomain']);
Route::get('/domain', [DomainController::class, 'getRating']);

//  Brand-specific routes
Route::get('/brand', [BrandController::class, 'getBrandInfo']);

//  Suggestion-specific routes
Route::get('/suggestions', [PromptController::class, 'getSuggestions']);

