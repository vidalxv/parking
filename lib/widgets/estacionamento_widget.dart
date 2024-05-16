import 'package:flutter/material.dart';
import '../models/estacionamento_model.dart';

class EstacionamentoCard extends StatelessWidget {
  final Estacionamento estacionamento;
  EstacionamentoCard({required this.estacionamento});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              estacionamento.foto,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            SizedBox(height: 10),
            Text(
              estacionamento.nome,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              estacionamento.endereco,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
