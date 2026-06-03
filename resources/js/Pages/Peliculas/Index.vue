<template>
  <Head title="Películas" />
  <div>
    <div class="flex items-center justify-between mb-8">
      <h1 class="text-2xl font-bold text-white flex items-center space-x-2">
        <svg class="w-6 h-6 text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"/></svg>
        <span>Películas</span>
      </h1>
      <Link href="/peliculas/create" class="bg-amber-600 hover:bg-amber-500 text-white font-medium py-2 px-4 rounded-lg shadow flex items-center space-x-1.5 transition">
        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
        <span>Nueva película</span>
      </Link>
    </div>

    <div v-if="peliculas.length === 0" class="text-center py-20 text-slate-500">
      <svg class="mx-auto h-12 w-12 text-slate-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"/></svg>
      <p class="mt-4">No hay películas registradas.</p>
    </div>

    <div v-else class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
      <div v-for="pelicula in peliculas" :key="pelicula.id" class="bg-slate-800 border border-slate-700 rounded-xl overflow-hidden group hover:border-amber-500/30 transition">
        <div class="relative h-48 bg-slate-700">
          <img v-if="pelicula.poster_url" :src="pelicula.poster_url" alt="Póster" class="w-full h-full object-cover" />
          <div v-else class="flex items-center justify-center h-full text-slate-500">
            <svg class="w-10 h-10" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
          </div>
          <!-- Overlay con acciones rápidas -->
          <div class="absolute inset-0 bg-black/60 opacity-0 group-hover:opacity-100 transition flex items-center justify-center space-x-3">
            <Link :href="`/peliculas/${pelicula.id}`" class="p-2 bg-amber-500 rounded-full text-white hover:bg-amber-400 transition">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>
            </Link>
            <Link :href="`/peliculas/${pelicula.id}/edit`" class="p-2 bg-blue-500 rounded-full text-white hover:bg-blue-400 transition">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>
            </Link>
            <button @click="destroy(pelicula.id)" class="p-2 bg-red-500 rounded-full text-white hover:bg-red-400 transition">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
            </button>
          </div>
        </div>
        <div class="p-4">
          <h3 class="font-semibold text-white truncate">{{ pelicula.titulo }}</h3>
          <p class="text-sm text-slate-400">{{ pelicula.genero }} &middot; {{ pelicula.duracion }} min</p>
          <p class="text-xs text-slate-500 mt-1">Sala: {{ pelicula.sala?.nombre }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
defineProps({ peliculas: Array });
const destroy = (id) => {
  if (confirm('¿Eliminar esta película?')) {
    useForm({}).delete(`/peliculas/${id}`);
  }
};
</script>
