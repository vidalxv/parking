import 'package:flutter/material.dart';

class Vagas extends StatefulWidget {
  const Vagas({super.key});

  @override
  State<Vagas> createState() => _VagasState();
}

class _VagasState extends State<Vagas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_parking),
        title: const Text('Vagas',
        ),
      ),
      body: Center(
        child: Text(
          'oi',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}