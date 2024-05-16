import 'package:flutter/material.dart';
import 'package:parking/themes/theme.dart';
import '../models/estacionamento_model.dart';

class EstacionamentoCard extends StatelessWidget {
  
  final Estacionamento estacionamento;
  EstacionamentoCard({required this.estacionamento});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Borda arredondada
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 16, 16, 16).withOpacity(1.0), 
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Mudança de posição da sombra
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                estacionamento.foto,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            color: Color.fromARGB(255, 195, 195, 195),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Roxo, 
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
    );
  }
}
