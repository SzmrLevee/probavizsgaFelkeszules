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
                'title' => 'Front Wing (Spec-A)',
                'status' => 'open',
                'vendor_id' => 1,
                'price' => 1250000,
                'quantity' => 4,
                'description' => 'Nagy leszorítóerő, gyors pályákra optimalizálva.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Rear Wing (Spec-L)',
                'status' => 'negotiating',
                'vendor_id' => 1,
                'price' => 990000,
                'quantity' => 3,
                'description' => 'Alacsony légellenállás, hosszú egyenesekre.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Floor Edge Kit',
                'status' => 'open',
                'vendor_id' => 3,
                'price' => 760000,
                'quantity' => 6,
                'description' => 'Stabilabb áramlás, kevesebb pattogás.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'ERS Battery Pack',
                'status' => 'open',
                'vendor_id' => 2,
                'price' => 2100000,
                'quantity' => 2,
                'description' => 'Nagy sűrűségű energiatárolás, verseny-spec.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Turbocharger Unit',
                'status' => 'archived',
                'vendor_id' => 4,
                'price' => 1850000,
                'quantity' => 1,
                'description' => 'Gyorsabb spool, javított hőmenedzsment.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'MGU-K Module',
                'status' => 'sold',
                'vendor_id' => 4,
                'price' => 1450000,
                'quantity' => 0,
                'description' => 'Hatékonyabb energia-visszanyerés (utolsó darab eladva).',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'ECU (FIA Standard)',
                'status' => 'open',
                'vendor_id' => 2,
                'price' => 320000,
                'quantity' => 10,
                'description' => 'Szoftveres telemetria + alap vezérlés.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Telemetry Antenna',
                'status' => 'negotiating',
                'vendor_id' => 3,
                'price' => 180000,
                'quantity' => 12,
                'description' => 'Stabilabb adatkapcsolat a boxfalhoz.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Team Cap (Classic)',
                'status' => 'open',
                'vendor_id' => 5,
                'price' => 6500,
                'quantity' => 120,
                'description' => 'Hímzett logó, állítható pánt.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Pit Crew Gloves',
                'status' => 'open',
                'vendor_id' => 5,
                'price' => 24000,
                'quantity' => 25,
                'description' => 'Hőálló kesztyű gyors kerékcseréhez.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
