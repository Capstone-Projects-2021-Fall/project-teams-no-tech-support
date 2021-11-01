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
        $errorText = 'brand name cannot be blank';

        if(strlen($brand) > 0) {
            $brandData = Brand::where('name', $brand)->pluck('tech_support_number')->all();

            if(count($brandData) > 0) {
                $phone = $brandData[0];

                if(strlen($phone) > 0) {
                    return response()->json(['phone' => $phone]);
                }
            }

            $errorText = 'no tech support number found for brand with name ' . $brand;
        }
        
        return response()->json(['error' => 'Backend API returned error: '.$errorText]);
    }
}
