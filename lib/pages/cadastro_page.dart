import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registrar() async {
  String email = _emailController.text;
  String senha = _senhaController.text;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );

    // Registro bem-sucedido, exiba uma mensagem
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registro bem-sucedido')),
    );

    // Imprima o ID do usuário recém-registrado
    print('Usuário registrado: ${userCredential.user!.uid}');
    
    // Você pode redirecionar o usuário para outra página aqui, se necessário
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('A senha é muito fraca');
    } else if (e.code == 'email-already-in-use') {
      print('O e-mail já está em uso');
    }
  } catch (e) {
    print(e);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _registrar,
              child: Text('Registrar'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
