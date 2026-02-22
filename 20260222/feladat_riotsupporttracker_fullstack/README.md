# RiotSupportTracker -- Szomor Levente SZFT5

Az alábbi fájl feladat → megoldás párokat tartalmaz. A megoldások minden
esetben teljes, másolható kódot tartalmaznak.

------------------------------------------------------------------------

# 1. Migrációk

## create_agents_table

``` php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('agents', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('agents');
    }
};
```


    ## create_tickets_table

    ```php
    <?php

    use Illuminate\Database\Migrations\Migration;
    use Illuminate\Database\Schema\Blueprint;
    use Illuminate\Support\Facades\Schema;

    return new class extends Migration
    {
        public function up(): void
        {
            Schema::create('tickets', function (Blueprint $table) {
                $table->id();
                $table->string('title', 100);
                $table->string('status', 20)->default('open');
                $table->foreignId('agent_id')->nullable()->constrained('agents')->nullOnDelete();
                $table->string('description', 2000);
            });
        }

        public function down(): void
        {
            Schema::dropIfExists('tickets');
        }
    };


    ---

    # 2. Modellek

    ## Agent.php

    ```php
    <?php

    namespace App\Models;

    use Illuminate\Database\Eloquent\Model;

    class Agent extends Model
    {
        public $timestamps = false;

        protected $fillable = ['name'];

        public function tickets()
        {
            return $this->hasMany(Ticket::class);
        }
    }


    ## Ticket.php

    ```php
    <?php

    namespace App\Models;

    use Illuminate\Database\Eloquent\Model;

    class Ticket extends Model
    {
        public $timestamps = false;

        protected $fillable = [
            'title',
            'status',
            'agent_id',
            'description',
        ];

        protected $attributes = [
            'status' => 'open',
        ];

        public function agent()
        {
            return $this->belongsTo(Agent::class);
        }
    }


    ---

    # 3. API Route-ok

    ```php
    <?php

    use Illuminate\Support\Facades\Route;
    use App\Http\Controllers\TicketController;
    use App\Http\Controllers\AgentController;

    Route::get('/tickets', [TicketController::class, 'index']);
    Route::get('/tickets/{ticket}', [TicketController::class, 'show'])->whereNumber('ticket');
    Route::post('/tickets', [TicketController::class, 'store']);
    Route::put('/tickets/{ticket}', [TicketController::class, 'update'])->whereNumber('ticket');
    Route::delete('/tickets/{ticket}', [TicketController::class, 'destroy'])->whereNumber('ticket');

    Route::get('/agents', [AgentController::class, 'index']);
    Route::get('/agents/{agent}', [AgentController::class, 'show'])->whereNumber('agent');


    ---

    # 4. TicketStore.mjs

    ```js
    import { api } from '@utils/http.mjs'
    import { defineStore } from 'pinia'
    import { ref, computed } from 'vue'

    export const useTicketStore = defineStore('tickets', () => {
      const tickets = ref([])
      const isLoading = ref(true)

      async function load() {
        const res = await api.get('/api/tickets')
        const list = res?.data?.data ?? res?.data ?? []
        tickets.value = Array.isArray(list) ? list : []
        isLoading.value = false
      }

      function unwrapItem(res) {
        return res?.data?.data ?? res?.data ?? null
      }

      async function getTicket(id) {
        const res = await api.get(`/api/tickets/${id}`)
        return unwrapItem(res)
      }

      async function createTicket(ticket) {
        const res = await api.post('/api/tickets', ticket)
        const created = unwrapItem(res)
        if (created) tickets.value.push(created)
        return created
      }

      async function updateTicket(id, ticket) {
        const res = await api.put(`/api/tickets/${id}`, ticket)
        const updated = unwrapItem(res)

        const index = tickets.value.findIndex(t => t.id == id)
        if (index !== -1 && updated) {
          tickets.value[index] = updated
        }

        return updated
      }

      async function deleteTicket(id) {
        await api.delete(`/api/tickets/${id}`)
        tickets.value = tickets.value.filter(t => t.id != id)
      }

      const statuses = computed(() => ({
        open: 'Nyitott',
        investigating: 'Vizsgálat alatt',
        resolved: 'Megoldva',
        closed: 'Lezárva',
      }))

      load()

      return {
        tickets,
        isLoading,
        load,
        getTicket,
        createTicket,
        updateTicket,
        deleteTicket,
        statuses,
      }
    })


    ---

    # 5. BaseCard.vue

    ```vue
    <script setup>
    defineProps({
      url: { type: String, required: true },
      title: { type: String, required: true },
      subtitle: { type: String, default: '' },
    })
    </script>

    <template>
      <router-link
        :to="url"
        class="block rounded border border-neutral-800 p-2 hover:shadow"
      >
        <h5 class="font-semibold">{{ title }}</h5>
        <p v-if="subtitle" class="text-sm opacity-80">{{ subtitle }}</p>
      </router-link>
    </template>


    ---

    # 6. index.vue

    ```vue
    <script setup>
    import { computed } from 'vue'
    import BaseLayout from '@/layouts/BaseLayout.vue'
    import BaseCard from '@/components/BaseCard.vue'
    import { useTicketStore } from '@/stores/TicketStore.mjs'

    const ticketStore = useTicketStore()

    const ticketsByStatus = computed(() => {
      const groups = { open: [], investigating: [], resolved: [], closed: [] }

      for (const t of ticketStore.tickets ?? []) {
        const key = t.status ?? 'open'
        groups[key].push(t)
      }

      return groups
    })
    </script>

    <template>
      <BaseLayout>
        <div class="grid gap-4 lg:grid-cols-4">
          <div
            v-for="(label, statusKey) in ticketStore.statuses"
            :key="statusKey"
            class="p-4 bg-neutral-100 rounded"
          >
            <div class="text-center font-semibold">{{ label }}</div>

            <div class="mt-2 space-y-2">
              <BaseCard
                v-for="ticket in ticketsByStatus[statusKey]"
                :key="ticket.id"
                :url="`/tickets/${ticket.id}`"
                :title="ticket.title"
              />
            </div>
          </div>
        </div>
      </BaseLayout>
    </template>

\`\`\`
