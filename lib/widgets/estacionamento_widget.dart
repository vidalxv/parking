import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/estacionamento_model.dart';
import 'package:parking/themes/theme.dart'; // Assumindo que você tenha um tema definido

class EstacionamentoCard extends StatefulWidget {
  final Estacionamento estacionamento;
  EstacionamentoCard({required this.estacionamento});

  @override
  _EstacionamentoCardState createState() => _EstacionamentoCardState();
}

class _EstacionamentoCardState extends State<EstacionamentoCard> {
  String? vagaSelecionada; // Para armazenar a vaga selecionada
  TimeOfDay? horaInicio; // Para armazenar o horário de início
  TimeOfDay? horaFim; // Para armazenar o horário de fim

  // Função para reservar vaga no Firestore
  Future<void> reservarVaga(Estacionamento estacionamento) async {
    if (vagaSelecionada == null || horaInicio == null || horaFim == null) {
      // Se algum campo não foi preenchido, exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    CollectionReference reservas = FirebaseFirestore.instance.collection('reservas');

    await reservas.add({
      'nome_estacionamento': estacionamento.nome,
      'endereco_estacionamento': estacionamento.endereco,
      'vaga': vagaSelecionada,
      'hora_inicio': '${horaInicio!.hour}:${horaInicio!.minute}',
      'hora_fim': '${horaFim!.hour}:${horaFim!.minute}',
      'data_reserva': DateTime.now(),
      'status': 'reservado',
    }).then((value) {
      print("Reserva feita com sucesso");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva feita com sucesso!')),
      );
    }).catchError((error) {
      print("Falha ao fazer a reserva: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao fazer a reserva: $error')),
      );
    });
  }

  // Função para abrir o seletor de horário
  Future<void> _selecionarHorarioInicio(BuildContext context) async {
    final TimeOfDay? selecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selecionado != null) {
      setState(() {
        horaInicio = selecionado;
      });
    }
  }

  // Função para abrir o seletor de horário
  Future<void> _selecionarHorarioFim(BuildContext context) async {
    final TimeOfDay? selecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selecionado != null) {
      setState(() {
        horaFim = selecionado;
      });
    }
  }

@override
Widget build(BuildContext context) {
  return SizedBox(
    height: 400, // Ajuste a altura conforme necessário
    child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 16, 16, 16).withOpacity(1.0),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.estacionamento.foto,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Exibição dos detalhes do estacionamento
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.estacionamento.nome,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.estacionamento.endereco,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 195, 195, 195),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    
                    // Dropdown para escolher a vaga
                    DropdownButtonFormField<String>(
                      dropdownColor: Color.fromARGB(255, 78, 66, 122),
                      decoration: InputDecoration(
                        labelText: 'Selecione a vaga',
                      ),
                      value: vagaSelecionada,
                      items: List.generate(12, (index) => 'A${index + 1}')
                          .map((vaga) => DropdownMenuItem(
                                value: vaga,
                                child: Text(vaga),
                              ))
                          .toList(),
                      onChanged: (valor) {
                        setState(() {
                          vagaSelecionada = valor;
                        });
                      },
                    ),
                    SizedBox(height: 10),

                    // Botões para selecionar o horário de início e fim
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => _selecionarHorarioInicio(context),
                          child: Text(
                            horaInicio == null
                                ? 'Horário de início'
                                : 'Início: ${horaInicio!.hour}:${horaInicio!.minute}',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selecionarHorarioFim(context),
                          child: Text(
                            horaFim == null
                                ? 'Horário de fim'
                                : 'Fim: ${horaFim!.hour}:${horaFim!.minute}',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Botão para reservar a vaga
                    ElevatedButton(
                      onPressed: () async {
                        await reservarVaga(widget.estacionamento);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Roxo, // Assumindo que você tenha definido a cor 'Roxo'
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Reservar Vaga',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}
