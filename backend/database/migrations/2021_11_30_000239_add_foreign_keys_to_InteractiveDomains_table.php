<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToInteractiveDomainsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('InteractiveDomains', function (Blueprint $table) {
            $table->foreign(['domain_id'], 'interactivedomains_ibfk_1')->references(['id'])->on('Domains');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('InteractiveDomains', function (Blueprint $table) {
            $table->dropForeign('interactivedomains_ibfk_1');
        });
    }
}
