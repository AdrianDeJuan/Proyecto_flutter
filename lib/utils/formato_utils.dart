/// Funciones sencillas para mantener el mismo formato en toda la aplicación.

/// Convierte un importe en céntimos a un precio legible.
String formatearPrecio(int centimos, String moneda) {
  final cantidad = (centimos / 100).toStringAsFixed(2).replaceAll('.', ',');
  final simbolo = moneda == 'EUR' ? '€' : moneda;
  return '$cantidad $simbolo';
}

/// Devuelve una fecha en formato largo, por ejemplo: 20 de noviembre de 2026.
String formatearFecha(DateTime fecha) {
  const meses = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
  ];
  return '${fecha.day} de ${meses[fecha.month - 1]} de ${fecha.year}';
}

/// Devuelve una fecha con el día de la semana.
String formatearDiaFecha(DateTime fecha) {
  const dias = [
    'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo',
  ];
  const meses = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
  ];
  return '${dias[fecha.weekday - 1]} ${fecha.day} de ${meses[fecha.month - 1]}';
}

/// Convierte una hora DateTime al formato HH:mm.
String formatearHora(DateTime fecha) {
  final hora = fecha.hour.toString().padLeft(2, '0');
  final minutos = fecha.minute.toString().padLeft(2, '0');
  return '$hora:$minutos';
}

/// Obtiene las iniciales de un nombre para mostrarlas en un avatar.
String obtenerIniciales(String nombre) {
  final partes = nombre.trim().split(RegExp(r'\s+'));
  if (partes.isEmpty || partes.first.isEmpty) return '?';
  if (partes.length == 1) return partes.first[0].toUpperCase();
  return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
}

/// Elimina la parte horaria de una fecha.
DateTime normalizarFecha(DateTime fecha) {
  return DateTime(fecha.year, fecha.month, fecha.day);
}

/// Comprueba si dos fechas corresponden al mismo día.
bool esMismoDia(DateTime primera, DateTime segunda) {
  return primera.year == segunda.year &&
      primera.month == segunda.month &&
      primera.day == segunda.day;
}
