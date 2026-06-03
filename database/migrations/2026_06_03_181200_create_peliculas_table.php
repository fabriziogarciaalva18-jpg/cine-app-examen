<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('peliculas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('sala_id')->constrained()->onDelete('cascade');
            $table->string('titulo', 200);
            $table->string('genero', 100);
            $table->integer('duracion')->unsigned()->comment('minutos');
            $table->string('poster')->nullable(); // almacenar
            $table->text('sinopsis')->nullable();
            $table->date('fecha_estreno')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('peliculas');
    }
};
