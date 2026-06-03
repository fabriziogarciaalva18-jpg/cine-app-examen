<template>
  <Head :title="pelicula.titulo" />
  <div class="max-w-5xl mx-auto">
    <div class="flex flex-wrap items-center justify-between gap-4 mb-6">
      <h1 class="text-3xl font-bold text-white">{{ pelicula.titulo }}</h1>
      <div class="flex space-x-2">
        <Link :href="`/peliculas/${pelicula.id}/edit`" class="bg-blue-600 hover:bg-blue-500 text-white font-medium py-2 px-4 rounded-lg shadow flex items-center space-x-1.5 transition">
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
      <div class="md:col-span-1">
        <img v-if="pelicula.poster_url" :src="pelicula.poster_url" alt="Póster" class="w-full rounded-xl shadow-lg object-cover" />
        <div v-else class="w-full h-64 bg-slate-800 rounded-xl flex items-center justify-center text-slate-600 border border-slate-700">
          <svg class="w-12 h-12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
        </div>
      </div>
      <div class="md:col-span-2 space-y-5">
        <div class="bg-slate-800 border border-slate-700 rounded-xl p-6">
          <h2 class="text-xl font-semibold text-white mb-3">Detalles</h2>
          <dl class="space-y-2 text-slate-300">
            <div class="flex">
              <dt class="font-medium text-slate-200 w-24">Sala:</dt>
              <dd>{{ pelicula.sala?.nombre }}</dd>
            </div>
            <div class="flex">
              <dt class="font-medium text-slate-200 w-24">Género:</dt>
              <dd>{{ pelicula.genero }}</dd>
            </div>
            <div class="flex">
              <dt class="font-medium text-slate-200 w-24">Duración:</dt>
              <dd>{{ pelicula.duracion }} min</dd>
            </div>
            <div class="flex" v-if="pelicula.fecha_estreno">
              <dt class="font-medium text-slate-200 w-24">Estreno:</dt>
              <dd>{{ new Date(pelicula.fecha_estreno).toLocaleDateString('es-ES') }}</dd>
            </div>
          </dl>
        </div>
        <div v-if="pelicula.sinopsis" class="bg-slate-800 border border-slate-700 rounded-xl p-6">
          <h2 class="text-xl font-semibold text-white mb-2">Sinopsis</h2>
          <p class="text-slate-300 leading-relaxed">{{ pelicula.sinopsis }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
const props = defineProps({ pelicula: Object });
const destroy = () => {
  if (confirm('¿Eliminar esta película?')) {
    useForm({}).delete(`/peliculas/${props.pelicula.id}`);
  }
};
</script>
