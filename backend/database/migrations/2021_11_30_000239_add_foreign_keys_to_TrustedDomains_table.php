<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToTrustedDomainsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('TrustedDomains', function (Blueprint $table) {
            $table->foreign(['domain_id'], 'trusteddomains_ibfk_1')->references(['id'])->on('Domains');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('TrustedDomains', function (Blueprint $table) {
            $table->dropForeign('trusteddomains_ibfk_1');
        });
    }
}
