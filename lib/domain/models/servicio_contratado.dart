class ServicioContratado {
  const ServicioContratado({
    required this.servicioId,
    required this.nombre,
    required this.precioCentimos,
  });

  //Sirve para que el importe se mantenga aunque cambie de precio por el objeto

  final String servicioId;
  final String nombre;
  final int precioCentimos;
}
