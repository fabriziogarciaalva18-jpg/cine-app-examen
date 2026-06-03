<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pelicula extends Model
{
    use HasFactory;

    protected $fillable = [
        'sala_id', 'titulo', 'genero', 'duracion',
        'poster', 'sinopsis', 'fecha_estreno'
    ];

    protected $casts = [
        'fecha_estreno' => 'date',
    ];

    public function sala()
    {
        return $this->belongsTo(Sala::class);
    }
}
