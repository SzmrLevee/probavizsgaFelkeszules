<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class VendorSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('vendors')->insert([
            ['name' => 'Stadium Merch Hub', 'city' => 'Dallas', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'FanZone Collect', 'city' => 'Los Angeles', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'MatchDay Market', 'city' => 'New York', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'GoalGear Store', 'city' => 'Toronto', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
