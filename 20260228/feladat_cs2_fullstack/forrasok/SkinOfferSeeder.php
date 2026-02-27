<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SkinOfferSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('skin_offers')->insert([
            [
                'trader_id' => 1,
                'category' => 'skin',
                'title' => 'Kés skin – Crimson Web (Field-Tested)',
                'tag' => 'KNIFE',
                'price' => 129000,
                'stock' => 1,
                'is_active' => 1,
                'listed_from' => '2026-02-01',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'trader_id' => 2,
                'category' => 'sticker',
                'title' => 'Sticker capsule – 2026 Major',
                'tag' => 'MAJOR',
                'price' => 5900,
                'stock' => 40,
                'is_active' => 1,
                'listed_from' => '2026-02-10',
                'listed_to' => '2026-04-30',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'trader_id' => 3,
                'category' => 'case',
                'title' => 'Case – Operation crate',
                'tag' => 'CASE',
                'price' => 2100,
                'stock' => 120,
                'is_active' => 1,
                'listed_from' => '2026-01-15',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'trader_id' => 4,
                'category' => 'glove',
                'title' => 'Gloves – Driver Gloves (Well-Worn)',
                'tag' => 'GLOVE',
                'price' => 39900,
                'stock' => 3,
                'is_active' => 1,
                'listed_from' => '2026-02-05',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
