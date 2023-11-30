import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pim4/model/reserva.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.0.156:5256/api';

  Future<void> submitReserva(Reserva reserva) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reservas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(reserva.toJson()),
    );

    if (response.statusCode == 200) {
      print('Reserva enviada com sucesso');
    } else {
      print(response);
      throw Exception('Falha ao enviar reserva');
    }
  }
}
