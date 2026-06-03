<?php

namespace App\Http\Controllers;

use App\Models\Pelicula;
use App\Models\Sala;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class PeliculaController extends Controller
{
    public function index()
    {
        $peliculas = Pelicula::with('sala')->latest()->get()->map(function ($pelicula) {
            $pelicula->poster_url = $pelicula->poster ? asset($pelicula->poster) : null;
            return $pelicula;
        });

        return Inertia::render('Peliculas/Index', [
            'peliculas' => $peliculas
        ]);
    }

    public function create()
    {
        return Inertia::render('Peliculas/Create', [
            'salas' => Sala::select('id', 'nombre')->get()
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'sala_id' => 'required|exists:salas,id',
            'titulo' => 'required|string|max:200',
            'genero' => 'required|string|max:100',
            'duracion' => 'required|integer|min:1',
            'sinopsis' => 'nullable|string',
            'fecha_estreno' => 'nullable|date',
            'poster' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('poster')) {
            $file = $request->file('poster');
            $filename = time() . '_' . preg_replace('/[^A-Za-z0-9\-\.]/', '', $file->getClientOriginalName());
            $file->move(public_path('posters'), $filename);
            $validated['poster'] = 'posters/' . $filename;
        }

        Pelicula::create($validated);

        return redirect()->route('peliculas.index')
            ->with('success', 'Película registrada.');
    }

    public function show(Pelicula $pelicula)
    {
        $pelicula->load('sala');
        $pelicula->poster_url = $pelicula->poster ? asset($pelicula->poster) : null;

        return Inertia::render('Peliculas/Show', [
            'pelicula' => $pelicula
        ]);
    }

    public function edit(Pelicula $pelicula)
    {
        $pelicula->poster_url = $pelicula->poster ? asset($pelicula->poster) : null;

        return Inertia::render('Peliculas/Edit', [
            'pelicula' => $pelicula,
            'salas' => Sala::select('id', 'nombre')->get()
        ]);
    }

    public function update(Request $request, Pelicula $pelicula)
    {
        $validated = $request->validate([
            'sala_id' => 'required|exists:salas,id',
            'titulo' => 'required|string|max:200',
            'genero' => 'required|string|max:100',
            'duracion' => 'required|integer|min:1',
            'sinopsis' => 'nullable|string',
            'fecha_estreno' => 'nullable|date',
            'poster' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('poster')) {
            // Eliminar imagen anterior si existe
            if ($pelicula->poster && File::exists(public_path($pelicula->poster))) {
                File::delete(public_path($pelicula->poster));
            }
            $file = $request->file('poster');
            $filename = time() . '_' . preg_replace('/[^A-Za-z0-9\-\.]/', '', $file->getClientOriginalName());
            $file->move(public_path('posters'), $filename);
            $validated['poster'] = 'posters/' . $filename;
        }

        $pelicula->update($validated);

        return redirect()->route('peliculas.index')
            ->with('success', 'Película actualizada.');
    }

    public function destroy(Pelicula $pelicula)
    {
        if ($pelicula->poster && File::exists(public_path($pelicula->poster))) {
            File::delete(public_path($pelicula->poster));
        }
        $pelicula->delete();

        return redirect()->route('peliculas.index')
            ->with('success', 'Película eliminada.');
    }
}
