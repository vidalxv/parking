import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/veiculo_model.dart';
import 'package:parking/repositories/veiculo_repository.dart'; // Importe o repositório
import 'package:parking/services/firebase_service.dart';

class EditarVeiculoPage extends StatefulWidget {
  final VeiculoModel? veiculo;
  final VeiculoRepository veiculoRepository;

  EditarVeiculoPage({Key? key, this.veiculo, required this.veiculoRepository}) : super(key: key);

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
    _modeloController = TextEditingController(text: widget.veiculo?.modelo ?? '');
    _corController = TextEditingController(text: widget.veiculo?.cor ?? '');
    _placaController = TextEditingController(text: widget.veiculo?.placa ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.veiculo == null ? 'Adicionar Veículo' : 'Editar Veículo'),
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
              child: Text(widget.veiculo == null ? 'Adicionar' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarVeiculo() async {
    String modelo = _modeloController.text.trim();
    String cor = _corController.text.trim();
    String placa = _placaController.text.trim();

    // Verifica se os campos estão preenchidos
    if (modelo.isNotEmpty && cor.isNotEmpty && placa.isNotEmpty) {
      AuthService authService = AuthService();
      String? userId = await authService.getCurrentUserID();
      if (userId != null) {
        // Verifica se já existe um veículo para este usuário
        QuerySnapshot veiculoSnapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .collection('veiculos')
            .get();

        if (veiculoSnapshot.docs.isNotEmpty) {
          // Se já existe um veículo, atualiza o primeiro veículo encontrado
          String veiculoId = veiculoSnapshot.docs.first.id;
          widget.veiculoRepository.atualizarVeiculo(
            userId,
            veiculoId,
            {
              'modelo': modelo,
              'cor': cor,
              'placa': placa,
            },
          ).then((_) {
            // Após atualizar o veículo com sucesso, retorna para a página anterior
            Navigator.pop(context);
          }).catchError((error) {
            // Caso ocorra algum erro ao atualizar o veículo
            print('Erro ao atualizar veículo: $error');
          });
        } else {
          // Se não existe veículo, adiciona um novo
          widget.veiculoRepository.adicionarVeiculo(
            userId,
            {
              'modelo': modelo,
              'cor': cor,
              'placa': placa,
            },
          ).then((_) {
            // Após adicionar o veículo com sucesso, retorna para a página anterior
            Navigator.pop(context);
          }).catchError((error) {
            // Caso ocorra algum erro ao adicionar o veículo
            print('Erro ao adicionar veículo: $error');
          });
        }
      } else {
        print('Usuário não está autenticado.');
      }
    } else {
      // Lógica para lidar com campos vazios
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
