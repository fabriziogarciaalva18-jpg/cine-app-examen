<template>
  <Head :title="sala.nombre" />
  <div class="max-w-4xl mx-auto">
    <div class="flex flex-wrap items-center justify-between gap-4 mb-6">
      <h1 class="text-3xl font-bold text-white">{{ sala.nombre }}</h1>
      <div class="flex space-x-2">
        <Link :href="`/salas/${sala.id}/edit`" class="bg-blue-600 hover:bg-blue-500 text-white font-medium py-2 px-4 rounded-lg shadow flex items-center space-x-1.5 transition">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>
          <span>Editar</span>
        </Link>
        <button @click="destroy" class="bg-red-600 hover:bg-red-500 text-white font-medium py-2 px-4 rounded-lg shadow flex items-center space-x-1.5 transition">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
          <span>Eliminar</span>
        </button>
      </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="md:col-span-1 bg-slate-800 rounded-xl border border-slate-700 p-5">
        <h2 class="text-lg font-semibold text-white mb-2">Detalles</h2>
        <div class="space-y-2 text-slate-300">
          <p><span class="font-medium text-slate-200">Capacidad:</span> {{ sala.capacidad }} asientos</p>
          <p><span class="font-medium text-slate-200">Películas asignadas:</span> {{ sala.peliculas.length }}</p>
        </div>
      </div>
      <div class="md:col-span-2">
        <h2 class="text-xl font-semibold text-white mb-4">Películas en esta sala</h2>
        <div v-if="sala.peliculas.length === 0" class="text-slate-500 py-10 text-center">Sin películas</div>
        <div v-else class="grid gap-4 sm:grid-cols-2">
          <div v-for="pelicula in sala.peliculas" :key="pelicula.id" class="bg-slate-800 border border-slate-700 rounded-xl overflow-hidden">
            <img v-if="pelicula.poster_url" :src="pelicula.poster_url" class="w-full h-32 object-cover" />
            <div v-else class="w-full h-32 bg-slate-700 flex items-center justify-center text-slate-500">
              <svg class="w-8 h-8" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
            </div>
            <div class="p-3">
              <h3 class="font-semibold text-white text-sm truncate">{{ pelicula.titulo }}</h3>
              <p class="text-xs text-slate-400">{{ pelicula.genero }} &middot; {{ pelicula.duracion }} min</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
const props = defineProps({ sala: Object });
const destroy = () => {
  if (confirm('¿Eliminar esta sala?')) {
    useForm({}).delete(`/salas/${props.sala.id}`);
  }
};
</script>
