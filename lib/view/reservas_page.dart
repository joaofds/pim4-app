import 'package:flutter/material.dart';
import 'package:pim4/model/reserva.dart';
import 'package:pim4/service/api_service.dart';
import 'package:pim4/view/confirmacao_page.dart';

class ReservasPage extends StatefulWidget {
  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  final TextEditingController _responsavelController = TextEditingController();

  Future<void> _submitReserva() async {
    final String responsavel = _responsavelController.text.trim();

    if (responsavel.isNotEmpty) {
      final Reserva reserva = Reserva(responsavel: responsavel);
      try {
        await ApiService().submitReserva(reserva);
        _mostrarSnackBar('Reserva enviada com sucesso!');
        _responsavelController.clear();

        // Navegar para a página de confirmação
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmacaoPage()),
        );
      } catch (error) {
        _mostrarSnackBar('Erro ao enviar reserva: $error');
      }
    } else {
      _mostrarSnackBar('Campo de responsável está vazio');
    }
  }

  void _mostrarSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _responsavelController,
              decoration: InputDecoration(labelText: 'Responsável'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReserva,
              child: Text('Enviar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
