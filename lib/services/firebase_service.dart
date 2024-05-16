import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking/models/estacionamento_model.dart';

Future<List<Estacionamento>> fetchEstacionamentos() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('estacionamentos').get();
  return snapshot.docs.map((doc) => Estacionamento.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
}
