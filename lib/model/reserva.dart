class Reserva {
  late String responsavel;

  Reserva({required this.responsavel});

  Map<String, dynamic> toJson() {
    return {
      'responsavel': responsavel,
    };
  }
}
