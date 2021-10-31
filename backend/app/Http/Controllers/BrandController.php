<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse as HttpJSONResponse;

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
     * @return HttpJSONResponse
     */
    public function getBrandInfo(Request $request) : HttpJSONResponse {
        $brand = $request->input('brand', '');
        if(strlen($brand) > 0) {
            $number = Brand::where('name', $brand)->pluck('tech_support_number')->all()[0];
            return response()->json(['phone' => $number]);
        }
        return response()->json(NULL);
    }
}
