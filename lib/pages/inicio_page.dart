import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/estacionamento_model.dart';
import 'package:parking/pages/veiculo_page.dart';
import 'package:parking/services/firebase_service.dart';
import 'package:parking/widgets/estacionamento_widget.dart';
import 'package:parking/repositories/veiculo_repository.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final AuthService _userService = AuthService(); 
  String? userId; 
  String modeloCarro = "";
  String placaCarro = "";
  late final String nome;
  late final String distancia;
  
  @override
  void initState() {
    super.initState();
    _getCurrentUser(); // Chamada para obter o usuário autenticado ao iniciar a página
  }

  void _getCurrentUser() async {
    userId = await _userService.getCurrentUserID(); // Obter ID do usuário autenticado

    // Se o usuário estiver autenticado, você pode buscar os dados do carro no Firestore
    if (userId != null) {
      try {
        // Obter os dados do carro associados ao usuário no Firestore
        // Ajuste o caminho para acessar o veículo específico
        QuerySnapshot carSnapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .collection('veiculos')
            .get();

        // Verificar se existe pelo menos um documento de veículo
        if (carSnapshot.docs.isNotEmpty) {
          // Obter o primeiro documento de veículo
          DocumentSnapshot carDocument = carSnapshot.docs.first;

          // Extrair os dados do carro do documento
          Map<String, dynamic>? carData = carDocument.data() as Map<String, dynamic>?;

          // Verificar se os dados do carro foram encontrados e acessar modelo e placa
          if (carData != null) {
            setState(() {
              modeloCarro = carData['modelo'] ?? ''; // Se 'modelo' for nulo, use uma string vazia
              placaCarro = carData['placa'] ?? ''; // Se 'placa' for nulo, use uma string vazia
            });
          }
        }
      } catch (e) {
        print("Erro ao obter dados do carro: $e");
      }
    }
  }

  Estacionamento exemploEstacionamento = Estacionamento(
    endereco: 'CASEB',
    nome: 'Shopping Boulevard',
    foto: 'https://allos.co/wp-content/uploads/2021/07/BlvdFeira-1.jpg',
  );
  Estacionamento senai = Estacionamento(
    endereco: 'Campo Limpo',
    nome: 'SENAI',
    foto: 'https://jornalgrandebahia.com.br/wp-content/uploads/2018/04/Fachada-do-edificio-de-aulas-do-SENAI-de-Feira-de-Santana.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: const Text('Inicio'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
          ),
          Card(
            color: Color.fromARGB(255, 78, 66, 122),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Image.asset(
                  './assets/images/carro.png',
                  width: 250,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          modeloCarro,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        subtitle: Text(
                          placaCarro,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 251, 251, 251)),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => EditarVeiculoPage(veiculoRepository: VeiculoRepository()),
                          );
                        },
                        child: Text(
                          'Editar Veiculo',
                          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Estacionamentos Próximos',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: ListTile(
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: Icon(Icons.local_parking_rounded),
                    title: Text('Shopping Boulevard'),
                    subtitle: Text('1,0 km'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => EstacionamentoCard(estacionamento: exemploEstacionamento),
                        );
                      },
                      child: Text('Detalhes'),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: ListTile(
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: Icon(Icons.local_parking_rounded),
                    title: Text('SENAI'),
                    subtitle: Text('2,4 km'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => EstacionamentoCard(estacionamento: senai),
                        );
                      },
                      child: Text('Detalhes'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
