<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class GarageListingSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('garage_listings')->insert([
            ['team_id' => 1, 'category' => 'aero', 'title' => 'Első szárny (spec 2026)', 'tag' => 'FRONTWING', 'price' => 199000, 'stock' => 2, 'is_active' => 1, 'listed_from' => '2026-02-01', 'listed_to' => null, 'created_at' => now(), 'updated_at' => now()],
            ['team_id' => 2, 'category' => 'engine', 'title' => 'Motorvezérlő egység (ECU)', 'tag' => 'ECU', 'price' => 149000, 'stock' => 4, 'is_active' => 1, 'listed_from' => '2026-01-20', 'listed_to' => null, 'created_at' => now(), 'updated_at' => now()],
            ['team_id' => 3, 'category' => 'tyre', 'title' => 'Gumi szett – közepes (M)', 'tag' => 'TYRE-M', 'price' => 59000, 'stock' => 10, 'is_active' => 1, 'listed_from' => '2026-02-10', 'listed_to' => '2026-06-30', 'created_at' => now(), 'updated_at' => now()],
            ['team_id' => 4, 'category' => 'gearbox', 'title' => 'Sebességváltó ház', 'tag' => 'GEARBOX', 'price' => 99000, 'stock' => 3, 'is_active' => 1, 'listed_from' => '2026-02-05', 'listed_to' => null, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
