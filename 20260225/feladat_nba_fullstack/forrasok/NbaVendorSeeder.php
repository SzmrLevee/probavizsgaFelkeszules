<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class VendorSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('vendors')->insert([
            ['name' => 'Duna Dunk Shop', 'city' => 'Budapest', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Tisza Tip-Off', 'city' => 'Szeged', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Debrecen Buzzer', 'city' => 'Debrecen', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Pécs Paint Collect', 'city' => 'Pécs', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
