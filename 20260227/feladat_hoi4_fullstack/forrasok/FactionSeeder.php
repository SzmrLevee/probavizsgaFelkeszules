<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FactionSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('factions')->insert([
            ['name' => 'Szövetségesek', 'hq_city' => 'London', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Tengely', 'hq_city' => 'Berlin', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Komintern', 'hq_city' => 'Moszkva', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Semleges blokk', 'hq_city' => 'Stockholm', 'rating' => 3, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
