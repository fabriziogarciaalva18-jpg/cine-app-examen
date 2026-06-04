<?php

use App\Http\Controllers\SalaController;
use App\Http\Controllers\PeliculaController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome');
});

Route::resource('salas', SalaController::class);
Route::resource('peliculas', PeliculaController::class);

// Ruta para health check de Render
Route::get('/up', function () {
    return response()->json(['status' => 'ok']);
});
