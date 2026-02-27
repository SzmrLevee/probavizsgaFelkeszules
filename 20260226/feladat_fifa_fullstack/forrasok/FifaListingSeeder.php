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
                'title' => '2026 VB mez – Magyarország (M)',
                'team' => 'Magyarország',
                'price' => 34900,
                'stock' => 5,
                'is_active' => 1,
                'listed_from' => '2026-05-20',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'vendor_id' => 2,
                'category' => 'scarf',
                'title' => 'Sál – Németország',
                'team' => 'Németország',
                'price' => 9900,
                'stock' => 20,
                'is_active' => 1,
                'listed_from' => '2026-05-15',
                'listed_to' => null,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'vendor_id' => 3,
                'category' => 'ball',
                'title' => 'Hivatalos meccslabda (replica)',
                'team' => 'FIFA 2026',
                'price' => 15900,
                'stock' => 12,
                'is_active' => 1,
                'listed_from' => '2026-05-10',
                'listed_to' => '2026-07-31',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'vendor_id' => 4,
                'category' => 'ticket',
                'title' => 'Csoportmeccs belépő – Toronto',
                'team' => 'FIFA 2026',
                'price' => 45000,
                'stock' => 2,
                'is_active' => 1,
                'listed_from' => '2026-06-01',
                'listed_to' => '2026-06-30',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
