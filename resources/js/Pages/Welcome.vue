<template>
  <Head title="Inicio" />
  <div class="flex flex-col items-center justify-center py-20">
    <div class="text-center max-w-2xl mx-auto">
      <div class="inline-flex items-center justify-center w-24 h-24 rounded-2xl bg-amber-500/10 border border-amber-500/20 mb-8">
        <svg class="w-12 h-12 text-amber-400" fill="currentColor" viewBox="0 0 24 24">
          <path d="M18 2a2 2 0 012 2v16a2 2 0 01-2 2H6a2 2 0 01-2-2V4a2 2 0 012-2zm0 2H6v16h12zM8 6h8v2H8zm0 4h8v2H8zm0 4h5v2H8z"/>
        </svg>
      </div>
      <h1 class="text-4xl sm:text-5xl font-extrabold text-white mb-4">
        Administración de <span class="text-amber-400">Cine</span>
      </h1>
      <p class="text-slate-400 text-lg mb-10">
        Gestiona salas, películas y cartelera desde un solo lugar.
      </p>
      <div class="flex flex-col sm:flex-row gap-4 justify-center">
        <Link href="/salas" class="group flex items-center justify-center space-x-2 bg-slate-700 hover:bg-slate-600 text-white font-semibold py-3 px-8 rounded-xl border border-slate-600 hover:border-amber-500/50 transition">
          <svg class="w-5 h-5 text-amber-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
          </svg>
          <span>Salas</span>
        </Link>
        <Link href="/peliculas" class="group flex items-center justify-center space-x-2 bg-amber-600 hover:bg-amber-500 text-white font-semibold py-3 px-8 rounded-xl shadow-lg shadow-amber-600/20 transition">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z" />
          </svg>
          <span>Películas</span>
        </Link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Head, Link } from '@inertiajs/vue3';
</script>
