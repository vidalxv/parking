import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking/models/veiculo_model.dart';

class EditarVeiculoPage extends StatefulWidget {
  final VeiculoModel? carro;

  EditarVeiculoPage({Key? key, this.carro}) : super(key: key);

  @override
  _EditarVeiculoPageState createState() => _EditarVeiculoPageState();
}

class _EditarVeiculoPageState extends State<EditarVeiculoPage> {
  late TextEditingController _modeloController;
  late TextEditingController _corController;
  late TextEditingController _placaController;

  @override
  void initState() {
    super.initState();
    _modeloController = TextEditingController(text: widget.carro?.modelo ?? '');
    _corController = TextEditingController(text: widget.carro?.cor ?? '');
    _placaController = TextEditingController(text: widget.carro?.placa ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro == null ? 'Adicionar Veículo' : 'Editar Veículo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Cor'),
            ),
            TextField(
              controller: _placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _salvarVeiculo();
              },
              child: Text(widget.carro == null ? 'Adicionar' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarVeiculo() {
    String modelo = _modeloController.text.trim();
    String cor = _corController.text.trim();
    String placa = _placaController.text.trim();

    if (modelo.isNotEmpty && cor.isNotEmpty && placa.isNotEmpty) {
      if (widget.carro == null) {
        // Adicionar um novo veículo
        FirebaseFirestore.instance.collection('carros').add({
          'modelo': modelo,
          'cor': cor,
          'placa': placa,
        }).then((value) {
          Navigator.pop(context);
        }).catchError((error) {
          // Tratar erros, se necessário
          print('Erro ao adicionar veículo: $error');
        });
      } else {
        // Editar um veículo existente
        FirebaseFirestore.instance.collection('carros').doc().update({
          'modelo': modelo,
          'cor': cor,
          'placa': placa,
        }).then((value) {
          Navigator.pop(context);
        }).catchError((error) {
          // Tratar erros, se necessário
          print('Erro ao editar veículo: $error');
        });
      }
    } else {
      // Exibir mensagem de erro se algum campo estiver vazio
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, preencha todos os campos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
