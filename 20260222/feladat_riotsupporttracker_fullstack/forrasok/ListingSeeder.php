<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ListingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('listings')->insert([
            [
                'id' => 1,
                'title' => 'OG Kush – gyors eladás',
                'status' => 'open',
                'dealer_id' => 1,
                'price' => 4500,
                'quantity' => 30,
                'description' => 'A Downtown körzetben nagy a kereslet, sürgős feltöltés kell.',
                'created_at' => '2026-02-01 10:00:00',
                'updated_at' => '2026-02-01 10:00:00',
            ],
            [
                'id' => 2,
                'title' => 'Sour Diesel – készletcsökkenés',
                'status' => 'investigating',
                'dealer_id' => 1,
                'price' => 4200,
                'quantity' => 20,
                'description' => 'A Harbor felől érkező konkurencia lenyomta az árat, új stratégiát kell nézni.',
                'created_at' => '2026-02-05 14:20:00',
                'updated_at' => '2026-02-06 09:10:00',
            ],
            [
                'id' => 3,
                'title' => 'Blue Dream – stabil kereslet',
                'status' => 'open',
                'dealer_id' => 2,
                'price' => 3900,
                'quantity' => 25,
                'description' => 'Uptown-ban folyamatos a rendelés, maradhat az alapár.',
                'created_at' => '2026-01-25 08:40:00',
                'updated_at' => '2026-01-25 08:40:00',
            ],
            [
                'id' => 4,
                'title' => 'Wax – limitált készlet',
                'status' => 'resolved',
                'dealer_id' => 2,
                'price' => 6500,
                'quantity' => 10,
                'description' => 'Csak kevés érkezett, a készlet frissítve lett.',
                'created_at' => '2026-02-10 11:05:00',
                'updated_at' => '2026-02-11 16:30:00',
            ],
            [
                'id' => 5,
                'title' => 'Shatter – túl magas ár',
                'status' => 'closed',
                'dealer_id' => 3,
                'price' => 7000,
                'quantity' => 8,
                'description' => 'A vásárlók nem vették, a listázás lezárva.',
                'created_at' => '2026-02-03 12:00:00',
                'updated_at' => '2026-02-18 18:00:00',
            ],
            [
                'id' => 6,
                'title' => 'Gummy (10mg) – nagy mennyiség',
                'status' => 'open',
                'dealer_id' => null,
                'price' => 1800,
                'quantity' => 40,
                'description' => 'Nincs még dealer hozzárendelve, csak előkészített hirdetés.',
                'created_at' => '2026-02-01 09:00:00',
                'updated_at' => '2026-02-01 09:00:00',
            ],
            [
                'id' => 7,
                'title' => 'Brownie (20mg) – visszajelzések gyűjtése',
                'status' => 'investigating',
                'dealer_id' => 4,
                'price' => 2600,
                'quantity' => 18,
                'description' => 'Több vevő panaszkodott a késői szállításra, vizsgálat folyamatban.',
                'created_at' => '2026-02-07 15:30:00',
                'updated_at' => '2026-02-08 10:00:00',
            ],
            [
                'id' => 8,
                'title' => 'Rolling Papers – állandó termék',
                'status' => 'open',
                'dealer_id' => 5,
                'price' => 500,
                'quantity' => 120,
                'description' => 'Alap kiegészítő, folyamatosan pótolni kell.',
                'created_at' => '2026-01-15 10:10:00',
                'updated_at' => '2026-01-15 10:10:00',
            ],
        ]);
    }
}
