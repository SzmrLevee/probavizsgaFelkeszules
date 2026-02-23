<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DealerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('dealers')->insert([
            [
                'id' => 1,
                'name' => 'Benjy',
                'district' => 'Downtown',
                'commission' => 12,
            ],
            [
                'id' => 2,
                'name' => 'Hector',
                'district' => 'Harbor',
                'commission' => 10,
            ],
            [
                'id' => 3,
                'name' => 'Mia',
                'district' => 'Uptown',
                'commission' => 15,
            ],
            [
                'id' => 4,
                'name' => 'Rico',
                'district' => 'Industrial',
                'commission' => 8,
            ],
            [
                'id' => 5,
                'name' => 'Tasha',
                'district' => 'Suburbs',
                'commission' => 11,
            ],
        ]);
    }
}
