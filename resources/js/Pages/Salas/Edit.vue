<template>
  <Head title="Editar Sala" />
  <div class="max-w-xl mx-auto">
    <h1 class="text-2xl font-bold text-white mb-6 flex items-center space-x-2">
      <svg class="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>
      <span>Editar sala</span>
    </h1>
    <form @submit.prevent="submit" class="bg-slate-800 border border-slate-700 rounded-xl p-6 space-y-5">
      <div>
        <label class="block text-sm font-medium text-slate-300 mb-1">Nombre</label>
        <input v-model="form.nombre" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
        <div v-if="form.errors.nombre" class="text-red-400 text-sm mt-1">{{ form.errors.nombre }}</div>
      </div>
      <div>
        <label class="block text-sm font-medium text-slate-300 mb-1">Capacidad</label>
        <input type="number" v-model="form.capacidad" class="w-full bg-slate-700 border border-slate-600 rounded-lg px-3 py-2 text-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
        <div v-if="form.errors.capacidad" class="text-red-400 text-sm mt-1">{{ form.errors.capacidad }}</div>
      </div>
      <div class="flex justify-end space-x-3 pt-4">
        <Link :href="`/salas/${sala.id}`" class="px-4 py-2 text-slate-400 hover:text-white font-medium transition">Cancelar</Link>
        <button type="submit" class="bg-blue-600 hover:bg-blue-500 text-white font-medium py-2 px-5 rounded-lg shadow transition flex items-center space-x-1.5">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
          <span>Actualizar</span>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
const props = defineProps({ sala: Object });
const form = useForm({ nombre: props.sala.nombre, capacidad: props.sala.capacidad });
const submit = () => form.put(`/salas/${props.sala.id}`);
</script>
