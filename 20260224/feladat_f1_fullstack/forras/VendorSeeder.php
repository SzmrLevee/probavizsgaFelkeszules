<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class VendorSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('vendors')->insert([
            ['name' => 'Apex Components', 'paddock_zone' => 'Garage Row', 'discount' => 8, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'GridTech Supply', 'paddock_zone' => 'Media Center', 'discount' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'VeloDynamics', 'paddock_zone' => 'Paddock Club', 'discount' => 10, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'TorqueWorks', 'paddock_zone' => 'Hospitality', 'discount' => 6, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'PitLane Merch', 'paddock_zone' => 'Fan Zone', 'discount' => 12, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
