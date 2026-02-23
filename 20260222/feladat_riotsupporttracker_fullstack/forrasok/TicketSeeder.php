<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Ticket;

class TicketSeeder extends Seeder
{
    public function run(): void
    {
        $tickets = [
            [
                'title' => 'VAN 128 - Vanguard után nem indul a League',
                'status' => 'open',
                'agent_id' => 3,
                'description' => 'A frissítés után a kliens indul, majd a játék nem startol. VAN 128 hibakód jelenik meg. Újraindítás és javítás nem segített. Kérlek vizsgáljátok meg a Vanguard szolgáltatást és a kompatibilitást.',
            ],
            [
                'title' => 'Riot Client beragad "Signing in..." képernyőn',
                'status' => 'investigating',
                'agent_id' => 4,
                'description' => 'Bejelentkezéskor a kliens folyamatosan tölti a "Signing in" állapotot. Cache törlés és újratelepítés sem oldotta meg. Hálózati hiba nem látszik.',
            ],
            [
                'title' => 'Champion balance - túl domináns pick/ban, nerf javaslat',
                'status' => 'open',
                'agent_id' => 2,
                'description' => 'Több meccsen is azt tapasztaltuk, hogy egyes championok túl nagy előnnyel bírnak. Kérünk egy balansz felülvizsgálatot: túl magas túlélés + túl nagy sebzés, alacsony kockázattal.',
            ],
            [
                'title' => 'In-game crash a betöltőképernyőn (Windows 11)',
                'status' => 'resolved',
                'agent_id' => 1,
                'description' => 'A játék a betöltőképernyőn összeomlik, majd visszadob a desktopra. A logok alapján a grafikus driverrel lehet összefüggés. Driver frissítés után stabil lett.',
            ],
            [
                'title' => 'Hang bug - a játékban eltűnik a sfx, csak zene marad',
                'status' => 'closed',
                'agent_id' => null,
                'description' => 'Meccs közben eltűnik minden effekt hang, csak a zene marad. Újraindítás segít, de visszatér. Végül a hangkártya driver újratelepítése megoldotta.',
            ],
            [
                'title' => 'FPS droppok ARAM-ban, miközben a ping stabil',
                'status' => 'investigating',
                'agent_id' => 1,
                'description' => 'ARAM meccsekben rendszeres FPS droppok (120-ról 40-re), miközben a ping stabil. Grafikai beállítások csökkentése csak részben segít. Kérlek nézzétek meg, van-e ismert teljesítmény regresszió.',
            ],
        ];

        foreach ($tickets as $t) {
            if ($t['agent_id'] === null) $t['agent_id'] = null;
            Ticket::create($t);
        }
    }
}
