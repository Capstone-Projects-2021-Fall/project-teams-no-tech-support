<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToBrandTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('Brand', function (Blueprint $table) {
            $table->foreign(['device_id'], 'brand_ibfk_1')->references(['id'])->on('Device');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('Brand', function (Blueprint $table) {
            $table->dropForeign('brand_ibfk_1');
        });
    }
}
