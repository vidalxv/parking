import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking/services/firebase_service.dart';
import 'package:parking/pages/editar_perfil_page.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  AuthService _userService = AuthService();
  String? nome;
  String? email;
  String? telefone;
  String? endereco;
  String? dataNascimento;
  String? userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    print('Obtendo dados do usuário...');
    userId = await _userService.getCurrentUserID();
    if (userId != null) {
      DocumentSnapshot perfilSnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .get();

      if (perfilSnapshot.exists) {
        setState(() {
          nome = perfilSnapshot.get('nome');
          email = perfilSnapshot.get('email');
          telefone = perfilSnapshot.get('telefone');
          endereco = perfilSnapshot.get('endereco');
          dataNascimento = perfilSnapshot.get('dataNascimento');
        });
        print('Dados do perfil:');
      print('Nome: $nome');
      print('Email: $email');
      print('Telefone: $telefone');
      print('Endereço: $endereco');
      print('Data de Nascimento: $dataNascimento');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.settings),
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/5987/5987462.png",
                width: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              nome ?? 'Carregando...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${email ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Telefone: ${telefone ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Endereço: ${endereco ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Data de Nascimento: ${dataNascimento ?? ''}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditarPerfilPage(userId: userId)),
                );
                if (result == true) {
                  _getCurrentUser(); // Atualiza os dados do usuário ao retornar da página de edição
                }
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
