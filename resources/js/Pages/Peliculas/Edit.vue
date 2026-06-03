<template>
  <Head title="Editar Película" />
  <div class="max-w-2xl mx-auto">
    <h1 class="text-2xl font-bold text-white mb-6 flex items-center space-x-2">
      <svg class="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>
      <span>Editar película</span>
    </h1>
    <form @submit.prevent="submit" enctype="multipart/form-data" class="bg-slate-800 border border-slate-700 rounded-xl p-6 space-y-5">
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Sala</label>
          <select v-model="form.sala_id" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option value="">Seleccione una sala</option>
            <option v-for="sala in salas" :key="sala.id" :value="sala.id">{{ sala.nombre }}</option>
          </select>
          <div v-if="form.errors.sala_id" class="text-red-400 text-sm mt-1">{{ form.errors.sala_id }}</div>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Título</label>
          <input v-model="form.titulo" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500" />
          <div v-if="form.errors.titulo" class="text-red-400 text-sm mt-1">{{ form.errors.titulo }}</div>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Género</label>
          <input v-model="form.genero" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500" />
          <div v-if="form.errors.genero" class="text-red-400 text-sm mt-1">{{ form.errors.genero }}</div>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Duración (minutos)</label>
          <input type="number" v-model="form.duracion" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500" />
          <div v-if="form.errors.duracion" class="text-red-400 text-sm mt-1">{{ form.errors.duracion }}</div>
        </div>
        <div class="sm:col-span-2">
          <label class="block text-sm font-medium text-slate-300 mb-1">Sinopsis</label>
          <textarea v-model="form.sinopsis" rows="3" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Fecha de estreno</label>
          <input type="date" v-model="form.fecha_estreno" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-blue-500" />
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Póster actual</label>
          <div class="mt-1">
            <img v-if="pelicula.poster_url" :src="pelicula.poster_url" class="h-20 rounded-lg border border-slate-600 object-cover" />
            <span v-else class="text-slate-500 text-sm">Sin póster</span>
          </div>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Cambiar póster</label>
          <input type="file" @input="form.poster = $event.target.files[0]" accept="image/*" class="w-full text-sm text-slate-300 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-slate-600 file:text-white hover:file:bg-slate-500 transition" />
          <div v-if="form.errors.poster" class="text-red-400 text-sm mt-1">{{ form.errors.poster }}</div>
        </div>
      </div>
      <div class="flex justify-end space-x-3 pt-4">
        <Link :href="`/peliculas/${pelicula.id}`" class="px-4 py-2 text-slate-400 hover:text-white font-medium transition">Cancelar</Link>
        <button type="submit" class="bg-blue-600 hover:bg-blue-500 text-white font-medium py-2 px-5 rounded-lg shadow flex items-center space-x-1.5 transition">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
          <span>Actualizar</span>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
const props = defineProps({ pelicula: Object, salas: Array });
const form = useForm({
  sala_id: props.pelicula.sala_id,
  titulo: props.pelicula.titulo,
  genero: props.pelicula.genero,
  duracion: props.pelicula.duracion,
  sinopsis: props.pelicula.sinopsis,
  fecha_estreno: props.pelicula.fecha_estreno,
  poster: null,
});
const submit = () => form.put(`/peliculas/${props.pelicula.id}`);
</script>
