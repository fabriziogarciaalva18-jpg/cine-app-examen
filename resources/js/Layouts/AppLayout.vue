<template>
  <div class="min-h-screen bg-slate-900 text-slate-100 flex flex-col">
    <!-- Navbar -->
    <nav class="bg-slate-800 border-b border-slate-700 shadow-lg">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          <!-- Logo -->
          <Link href="/" class="flex items-center space-x-2 group">
            <svg class="w-7 h-7 text-amber-500 transition group-hover:scale-110" fill="currentColor" viewBox="0 0 24 24">
              <path d="M18 2a2 2 0 012 2v16a2 2 0 01-2 2H6a2 2 0 01-2-2V4a2 2 0 012-2zm0 2H6v16h12zM8 6h8v2H8zm0 4h8v2H8zm0 4h5v2H8z"/>
            </svg>
            <span class="text-xl font-bold tracking-tight text-white group-hover:text-amber-400 transition">CineAdmin</span>
          </Link>

          <!-- Links -->
          <div class="flex space-x-6 text-sm font-medium">
            <Link href="/salas" class="flex items-center space-x-1.5 text-slate-300 hover:text-amber-400 transition">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
              </svg>
              <span>Salas</span>
            </Link>
            <Link href="/peliculas" class="flex items-center space-x-1.5 text-slate-300 hover:text-amber-400 transition">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z" />
              </svg>
              <span>Películas</span>
            </Link>
          </div>
        </div>
      </div>
    </nav>

    <!-- Flash message -->
    <div v-if="$page.props.flash.success" class="bg-emerald-900 border-b border-emerald-700 text-emerald-200 px-4 py-2 text-center text-sm">
      {{ $page.props.flash.success }}
    </div>

    <!-- Main content -->
    <main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <slot />
    </main>

    <!-- Footer -->
    <footer class="bg-slate-800 border-t border-slate-700 text-slate-500 text-xs text-center py-4">
      &copy; {{ new Date().getFullYear() }} CineAdmin
    </footer>
  </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';
</script>
