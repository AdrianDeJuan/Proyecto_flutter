class FranjaDisponibilidadDto {
  const FranjaDisponibilidadDto({
    required this.disponible,
    required this.finIso,
    required this.inicioIso,
  });

  final String inicioIso;
  final String finIso;
  final bool disponible;
}
