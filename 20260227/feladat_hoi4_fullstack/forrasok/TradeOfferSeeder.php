<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TradeOfferSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('trade_offers')->insert([
            ['faction_id' => 1, 'category' => 'equipment', 'title' => 'Gyalogsági felszerelés csomag', 'tag' => 'INF', 'price' => 12000, 'stock' => 40, 'is_active' => 1, 'listed_from' => '1939-09-01', 'listed_to' => null, 'created_at' => now(), 'updated_at' => now()],
            ['faction_id' => 2, 'category' => 'tank', 'title' => 'Közepes tank licenc', 'tag' => 'PANZER', 'price' => 65000, 'stock' => 3, 'is_active' => 1, 'listed_from' => '1940-05-10', 'listed_to' => null, 'created_at' => now(), 'updated_at' => now()],
            ['faction_id' => 3, 'category' => 'intel', 'title' => 'Hírszerzési jelentés', 'tag' => 'INTEL', 'price' => 9000, 'stock' => 25, 'is_active' => 1, 'listed_from' => '1941-06-01', 'listed_to' => '1941-12-31', 'created_at' => now(), 'updated_at' => now()],
            ['faction_id' => 4, 'category' => 'factory', 'title' => 'Gyárkapacitás bérlet (30 nap)', 'tag' => 'CIV', 'price' => 18000, 'stock' => 10, 'is_active' => 1, 'listed_from' => '1939-10-01', 'listed_to' => '1939-10-31', 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
