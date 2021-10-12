<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SearchController;
use App\Http\Controllers\DomainController;


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

//  Basic route for accessing SearchController::getResults() (expects query)
Route::get('/results', [SearchController::class, 'getResults']);
Route::get('/rate', [DomainController::class, 'rateDomain']);
Route::get('/domain', [DomainController::class, 'getRating']);


