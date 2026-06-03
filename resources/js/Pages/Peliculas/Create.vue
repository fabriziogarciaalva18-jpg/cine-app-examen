<template>
  <Head title="Nueva Película" />
  <div class="max-w-2xl mx-auto">
    <h1 class="text-2xl font-bold text-white mb-6 flex items-center space-x-2">
      <svg class="w-6 h-6 text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
      <span>Agregar película</span>
    </h1>
    <form @submit.prevent="submit" enctype="multipart/form-data" class="bg-slate-800 border border-slate-700 rounded-xl p-6 space-y-5">
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Sala</label>
          <select v-model="form.sala_id" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-amber-500">
            <option value="">Seleccione una sala</option>
            <option v-for="sala in salas" :key="sala.id" :value="sala.id">{{ sala.nombre }}</option>
          </select>
          <div v-if="form.errors.sala_id" class="text-red-400 text-sm mt-1">{{ form.errors.sala_id }}</div>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Título</label>
          <input v-model="form.titulo" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-amber-500" />
          <div v-if="form.errors.titulo" class="text-red-400 text-sm mt-1">{{ form.errors.titulo }}</div>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Género</label>
          <input v-model="form.genero" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-amber-500" />
          <div v-if="form.errors.genero" class="text-red-400 text-sm mt-1">{{ form.errors.genero }}</div>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Duración (minutos)</label>
          <input type="number" v-model="form.duracion" min="1" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-amber-500" />
          <div v-if="form.errors.duracion" class="text-red-400 text-sm mt-1">{{ form.errors.duracion }}</div>
        </div>
        <div class="sm:col-span-2">
          <label class="block text-sm font-medium text-slate-300 mb-1">Sinopsis</label>
          <textarea v-model="form.sinopsis" rows="3" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-amber-500"></textarea>
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Fecha de estreno</label>
          <input type="date" v-model="form.fecha_estreno" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white focus:outline-none focus:ring-2 focus:ring-amber-500" />
        </div>
        <div>
          <label class="block text-sm font-medium text-slate-300 mb-1">Póster (imagen)</label>
          <input type="file" @input="form.poster = $event.target.files[0]" accept="image/*" class="w-full text-sm text-slate-300 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-slate-600 file:text-white hover:file:bg-slate-500 transition" />
          <div v-if="form.errors.poster" class="text-red-400 text-sm mt-1">{{ form.errors.poster }}</div>
        </div>
      </div>
      <div class="flex justify-end space-x-3 pt-4">
        <Link href="/peliculas" class="px-4 py-2 text-slate-400 hover:text-white font-medium transition">Cancelar</Link>
        <button type="submit" class="bg-amber-600 hover:bg-amber-500 text-white font-medium py-2 px-5 rounded-lg shadow flex items-center space-x-1.5 transition">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
          <span>Guardar</span>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
defineProps({ salas: Array });
const form = useForm({
  sala_id: '', titulo: '', genero: '', duracion: '',
  sinopsis: '', fecha_estreno: '', poster: null,
});
const submit = () => form.post('/peliculas');
</script>
