<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TeamSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('teams')->insert([
            ['name' => 'Red Falcon Racing', 'base_city' => 'Milton Keynes', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Silver Arrow GP', 'base_city' => 'Brackley', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Prancing Stallion', 'base_city' => 'Maranello', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Blue Wave Motorsport', 'base_city' => 'Enstone', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
