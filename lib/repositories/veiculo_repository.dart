import 'package:cloud_firestore/cloud_firestore.dart';

class VeiculoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarVeiculo(String userId, Map<String, dynamic> veiculoData) async {
    try {
      await _firestore.collection('usuarios').doc(userId).collection('veiculos').add(veiculoData);
    } catch (error) {
      throw Exception('Erro ao adicionar veículo: $error');
    }
  }

  Future<void> atualizarVeiculo(String userId, String veiculoId, Map<String, dynamic> veiculoData) async {
    try {
      await _firestore.collection('usuarios').doc(userId).collection('veiculos').doc(veiculoId).update(veiculoData);
    } catch (error) {
      throw Exception('Erro ao atualizar veículo: $error');
    }
  }

  Future<void> excluirVeiculo(String userId, String veiculoId) async {
    try {
      await _firestore.collection('usuarios').doc(userId).collection('veiculos').doc(veiculoId).delete();
    } catch (error) {
      throw Exception('Erro ao excluir veículo: $error');
    }
  }

  Stream<QuerySnapshot> listarVeiculos(String userId) {
    return _firestore.collection('usuarios').doc(userId).collection('veiculos').snapshots();
  }
}
