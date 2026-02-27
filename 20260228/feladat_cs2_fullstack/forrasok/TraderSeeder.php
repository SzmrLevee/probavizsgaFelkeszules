<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TraderSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('traders')->insert([
            ['name' => 'Dust2 Deals', 'city' => 'Budapest', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Mirage Market', 'city' => 'Berlin', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Inferno Exchange', 'city' => 'Warsaw', 'rating' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Nuke Vault', 'city' => 'Prague', 'rating' => 5, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
