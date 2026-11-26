class FranjaDisponibilidad {
  const FranjaDisponibilidad({
    required this.disponible,
    required this.fin,
    required this.inicio,
  });

  final DateTime inicio; //DateTime(año, mes, día + desplazamiento)
  final DateTime fin;
  final bool disponible;
}
