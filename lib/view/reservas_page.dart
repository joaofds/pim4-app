import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pim4/model/reserva.dart';
import 'package:pim4/service/api_service.dart';
import 'package:pim4/view/confirmacao_page.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  final TextEditingController _responsavelController = TextEditingController();
  final TextEditingController _dataReservaController = TextEditingController();

  Future<void> _submitReserva() async {
    final String responsavel = _responsavelController.text.trim();
    final String dataReserva = _dataReservaController.text.trim();

    if (kDebugMode) {
      print(_dataReservaController);
    }

    if (responsavel.isNotEmpty && dataReserva.isNotEmpty) {
      final Reserva reserva =
          Reserva(responsavel: responsavel, dataReserva: dataReserva);
      try {
        await ApiService().submitReserva(reserva);
        _mostrarSnackBar('Reserva enviada com sucesso!');
        _responsavelController.clear();
        _dataReservaController.clear();

        // Navegar para a página de confirmação
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConfirmacaoPage()),
        );
      } catch (error) {
        _mostrarSnackBar('Erro ao enviar reserva: $error');
      }
    } else {
      _mostrarSnackBar('Todos os campos são obrigatórios');
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
        title: const Text('Reservas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 50,
          top: 20,
          right: 50,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: _responsavelController,
                decoration: const InputDecoration(
                    labelText: 'Responsável',
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: TextField(
                controller: _dataReservaController,
                decoration: const InputDecoration(
                    labelText: 'Data da Reserva',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 120,
              child: ElevatedButton(
                onPressed: _submitReserva,
                child: const Text('Salvar'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if (selectedDate != null) {
      setState(() {
        _dataReservaController.text = selectedDate.toString().split(" ")[0];
      });
    }
  }
}
