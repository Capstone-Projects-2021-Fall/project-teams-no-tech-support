<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Brand;

/**
 * Controller class which handles all operations specific to Brand objects
 */
class BrandController extends Controller
{
    /**
     * Retrieve technical support contact information from the database and return it to the user
     * 
     * @param Request $request (String $brand)
     * @return int
     */
    public function getBrandInfo(Request $request) {
        $brand = $request->input('brand');

        return Brand::where('name', $brand)->pluck('tech_support_number')->all()[0];
    }
}
