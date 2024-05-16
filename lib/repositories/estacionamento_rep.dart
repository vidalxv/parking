import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class EstacionamentoRepository {
  final CollectionReference _estacionamentosCollection = FirebaseFirestore.instance.collection('estacionamentos');

  Future<void> adicionarEstacionamento({
    required double latitude,
    required double longitude,
    required String endereco,
    required String nome,
    required String foto,
  }) async {
    try {
      await _estacionamentosCollection.add({
        'latitude': latitude,
        'longitude': longitude,
        'endereco': endereco,
        'nome': nome,
        'foto': foto,
      });
    } catch (error) {
      throw 'Erro ao adicionar estacionamento: $error';
    }
  }

  Future<List<Map<String, dynamic>>> obterEstacionamentos() async {
  try {
    QuerySnapshot querySnapshot = await _estacionamentosCollection.get();
    List<Map<String, dynamic>> estacionamentos = [];
    querySnapshot.docs.forEach((doc) {
      // Verificar se os dados do documento não são nulos e se contêm a chave "latitude" antes de acessá-la
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('latitude')) {
        estacionamentos.add({
          'id': doc.id,
          'latitude': data['latitude'],
          'longitude': data['longitude'],
          'endereco': data['endereco'],
          'nome': data['nome'],
          'foto': data['foto'],
        });
      }
    });
    return estacionamentos;
  } catch (error) {
    throw 'Erro ao obter estacionamentos: $error';
  }
}


  Future<void> atualizarEstacionamento({
    required String id,
    required double latitude,
    required double longitude,
    required String endereco,
    required String nome,
    required String foto,
  }) async {
    try {
      await _estacionamentosCollection.doc(id).update({
        'latitude': latitude,
        'longitude': longitude,
        'endereco': endereco,
        'nome': nome,
        'foto': foto,
      });
    } catch (error) {
      throw 'Erro ao atualizar estacionamento: $error';
    }
  }

  Future<void> deletarEstacionamento(String id) async {
    try {
      await _estacionamentosCollection.doc(id).delete();
    } catch (error) {
      throw 'Erro ao deletar estacionamento: $error';
    }
  }

  Future<List<Map<String, dynamic>>> calcularMaisProximos(double userLatitude, double userLongitude) async {
  try {
    // Verificar se as coordenadas de latitude e longitude estão dentro do intervalo válido
    if (userLatitude < -90 || userLatitude > 90 || userLongitude < -180 || userLongitude > 180) {
      throw 'Coordenadas de localização inválidas';
    }

    // Obter todos os estacionamentos
    List<Map<String, dynamic>> estacionamentos = await obterEstacionamentos();

    // Calcular distância entre o usuário e cada estacionamento
    for (var estacionamento in estacionamentos) {
      double latitude = estacionamento['latitude'];
      double longitude = estacionamento['longitude'];

      // Verificar se as coordenadas do estacionamento estão dentro do intervalo válido
      if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
        throw 'Coordenadas do estacionamento inválidas';
      }

      double distancia = Geolocator.distanceBetween(
        userLatitude,
        userLongitude,
        latitude,
        longitude,
      );

      // Adicionar a distância ao mapa do estacionamento
      estacionamento['distancia'] = distancia;
    }

    // Ordenar os estacionamentos com base na distância
    estacionamentos.sort((a, b) => (a['distancia'] as double).compareTo(b['distancia'] as double));

    return estacionamentos;
  } catch (error) {
    throw 'Erro ao calcular estacionamentos mais próximos: $error';
  }
}
} 