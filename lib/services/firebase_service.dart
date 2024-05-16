import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/models/veiculo_model.dart';
import 'package:parking/models/estacionamento_model.dart';

Future<List<Estacionamento>> fetchEstacionamentos() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('estacionamentos').get();
  return snapshot.docs.map((doc) => Estacionamento.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
}

Future<VeiculoModel> getVeiculoModelFromFirestore(String id) async {
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('VeiculoModels').doc(id).get();
  return VeiculoModel.fromFirestore(doc);
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<String?> getCurrentUserID() async {
    User? user = _auth.currentUser;
    return user?.uid;
  }
}




