<?php

namespace App\Http\Controllers;

use App\Models\Sala;
use Inertia\Inertia;
use Illuminate\Http\Request;

class SalaController extends Controller
{
    public function index()
    {
        return Inertia::render('Salas/Index', [
            'salas' => Sala::withCount('peliculas')->latest()->get()
        ]);
    }

    public function create()
    {
        return Inertia::render('Salas/Create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:100',
            'capacidad' => 'required|integer|min:1',
        ]);

        Sala::create($validated);

        return redirect()->route('salas.index')
            ->with('success', 'Sala creada exitosamente.');
    }

    public function show(Sala $sala)
    {
        $sala->load('peliculas');

        $sala->peliculas->transform(function ($pelicula) {
            $pelicula->poster_url = $pelicula->poster ? asset($pelicula->poster) : null;
            return $pelicula;
        });

        return Inertia::render('Salas/Show', [
            'sala' => $sala
        ]);
    }

    public function edit(Sala $sala)
    {
        return Inertia::render('Salas/Edit', [
            'sala' => $sala
        ]);
    }

    public function update(Request $request, Sala $sala)
    {
        $validated = $request->validate([
            'nombre' => 'required|string|max:100',
            'capacidad' => 'required|integer|min:1',
        ]);

        $sala->update($validated);

        return redirect()->route('salas.index')
            ->with('success', 'Sala actualizada.');
    }

    public function destroy(Sala $sala)
    {
        $sala->delete();
        return redirect()->route('salas.index')
            ->with('success', 'Sala eliminada.');
    }
}
