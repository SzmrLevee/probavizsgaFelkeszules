<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Agent;

class AgentSeeder extends Seeder
{
    public function run(): void
    {
        $agents = [
            ['name' => 'Lilla "Queue" Nagy'],
            ['name' => 'Bence "Patch" Kiss'],
            ['name' => 'Zsófi "Vanguard" Tóth'],
            ['name' => 'Máté "Client" Szabó'],
        ];

        foreach ($agents as $a) {
            Agent::create($a);
        }
    }
}
