import 'package:cloud_firestore/cloud_firestore.dart';

class VeiculoModel {
  String tipo;
  String modelo;
  String cor;
  String placa;

  VeiculoModel({required this.tipo, required this.modelo, required this.cor, required this.placa});

  factory VeiculoModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return VeiculoModel(
      tipo: data['veiculo'] ?? '',
      modelo: data['modelo'] ?? '',
      cor: data['cor'] ?? '',
      placa: data['placa'] ?? '',
    );
  }
}
