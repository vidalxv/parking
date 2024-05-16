import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarPerfilPage extends StatefulWidget {
  final String? userId;

  EditarPerfilPage({Key? key, required this.userId}) : super(key: key);

  @override
  _EditarPerfilPageState createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _enderecoController;
  late TextEditingController _dataNascimentoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _telefoneController = TextEditingController();
    _enderecoController = TextEditingController();
    _dataNascimentoController = TextEditingController();
    _getPerfil();
  }

  void _getPerfil() async {
    if (widget.userId != null) {
      DocumentSnapshot perfilSnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(widget.userId)
          .get();

      if (perfilSnapshot.exists) {
        setState(() {
          _nomeController.text = perfilSnapshot.get('nome');
          _emailController.text = perfilSnapshot.get('email');
          _telefoneController.text = perfilSnapshot.get('telefone');
          _enderecoController.text = perfilSnapshot.get('endereco');
          _dataNascimentoController.text = perfilSnapshot.get('dataNascimento');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextField(
              controller: _enderecoController,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: _dataNascimentoController,
              decoration: InputDecoration(labelText: 'Data de Nascimento'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _salvarPerfil();
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarPerfil() async {
    String nome = _nomeController.text.trim();
    String email = _emailController.text.trim();
    String telefone = _telefoneController.text.trim();
    String endereco = _enderecoController.text.trim();
    String dataNascimento = _dataNascimentoController.text.trim();

    // Verifica se os campos estão preenchidos
    if (nome.isNotEmpty && email.isNotEmpty && telefone.isNotEmpty && endereco.isNotEmpty && dataNascimento.isNotEmpty) {
      if (widget.userId != null) {
        await FirebaseFirestore.instance.collection('usuarios').doc(widget.userId).set({
          'nome': nome,
          'email': email,
          'telefone': telefone,
          'endereco': endereco,
          'dataNascimento': dataNascimento,
        }, SetOptions(merge: true)).then((_) {
          // Após salvar o perfil com sucesso, retorna para a página anterior com um valor indicando sucesso
          Navigator.pop(context, true);
        }).catchError((error) {
          // Caso ocorra algum erro ao salvar o perfil
          print('Erro ao salvar perfil: $error');
        });
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
