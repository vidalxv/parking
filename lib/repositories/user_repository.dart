import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para adicionar um novo usuário ao Firestore
  Future<void> adicionarUsuario(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('usuarios').doc(userId).set(userData);
    } catch (error) {
      throw error; // Lança o erro para ser tratado pela camada superior
    }
  }

  // Método para atualizar os dados de um usuário existente no Firestore
  Future<void> atualizarUsuario(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('usuarios').doc(userId).update(userData);
    } catch (error) {
      throw error; // Lança o erro para ser tratado pela camada superior
    }
  }

  // Método para obter os dados de um usuário a partir do Firestore
  Future<Map<String, dynamic>?> obterUsuario(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('usuarios').doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        return null; // Retorna null se o usuário não existir
      }
    } catch (error) {
      throw error; // Lança o erro para ser tratado pela camada superior
    }
  }
}
