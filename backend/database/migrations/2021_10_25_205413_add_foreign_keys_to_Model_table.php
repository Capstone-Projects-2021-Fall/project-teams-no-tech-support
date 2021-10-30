<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToModelTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('Model', function (Blueprint $table) {
            $table->foreign(['brand_id'], 'model_ibfk_1')->references(['id'])->on('Brand');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('Model', function (Blueprint $table) {
            $table->dropForeign('model_ibfk_1');
        });
    }
}
