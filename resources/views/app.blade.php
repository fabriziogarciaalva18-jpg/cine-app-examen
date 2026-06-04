<!DOCTYPE html>
<html lang="es" class="dark"> <!-- Añadimos 'class="dark"' para que se activen tus fondos oscuros text-white -->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cine App</title>


    @routes
    <!-- ¡Crucial! Verificamos que cargue tanto el CSS como el JS en la ruta exacta -->
    @vite(['resources/js/app.js', 'resources/css/app.css'])
</head>
<body class="font-sans antialiased bg-slate-900 text-slate-100">
    @inertia
</body>
</html>
