class Reserva {
  late String responsavel;
  late String dataReserva;

  Reserva({required this.responsavel, required this.dataReserva});

  Map<String, dynamic> toJson() {
    return {'Responsavel': responsavel, 'DataReserva': dataReserva};
  }
}
