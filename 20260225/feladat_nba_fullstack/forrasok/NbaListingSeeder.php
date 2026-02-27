<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ListingSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('listings')->insert([
            [
                'vendor_id' => 1,
                'category' => 'jersey',
                'title' => 'Lakers City Edition mez (M)',
                'team' => 'Los Angeles Lakers',
                'price' => 32000,
                'stock' => 4,
                'is_active' => 1,
                'listed_from' => '2026-02-01',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'vendor_id' => 2,
                'category' => 'card',
                'title' => 'Rookie kártya (tokkal)',
                'team' => 'San Antonio Spurs',
                'price' => 12000,
                'stock' => 6,
                'is_active' => 1,
                'listed_from' => '2026-02-03',
                'listed_to' => '2026-02-18',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'vendor_id' => 3,
                'category' => 'shoe',
                'title' => 'Signature cipő (44)',
                'team' => 'Dallas Mavericks',
                'price' => 45000,
                'stock' => 1,
                'is_active' => 1,
                'listed_from' => '2026-01-28',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'vendor_id' => 4,
                'category' => 'relic',
                'title' => 'Aláírt labda (hitelesített)',
                'team' => 'Miami Heat',
                'price' => 60000,
                'stock' => 1,
                'is_active' => 1,
                'listed_from' => '2026-01-20',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
