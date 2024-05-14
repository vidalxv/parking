import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: const Text('Inicio',
        ),
      ),
      body: Column(
              children: [
                Container(
                  margin:EdgeInsets.symmetric(vertical: 10.0),
                ),
                Card(
                  color: Color.fromARGB(255, 78, 66, 122),
                  margin:EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [Image.asset(
                      './assets/images/carro.png',
                    width: 250,
                    height: 150,
                    fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [ 
                        ListTile(
                        contentPadding: EdgeInsets.zero, // Remove o espaçamento padrão do ListTile
                        title: Text(
                          'Renault Sandero',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)
                            ),
                          ),
                        subtitle: Text(
                          'PCG-4234',
                          textAlign: TextAlign.center
                          , style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)
                            ),),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>( Color.fromARGB(255, 251, 251, 251)),
                        ),
                        onPressed: () { },
                        child: Text(
                          'Editar Veiculo',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0)
                            ),
                          ),
                        ), 
                     ]),
                    ),
                  ],
                  ),
                ),
                Container(
                  margin:EdgeInsets.symmetric(vertical: 10.0),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Estacionamentos Próximos',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Card(
                        margin:EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          leading: Icon(Icons.local_parking_rounded),
                          title: Text('Shopping Boulevard'),
                          subtitle: Text('1,0 km'),
                          trailing: ElevatedButton(
                            onPressed: () => {},
                            child: Text('Detalhes'),
                          ),
                        ),
                      ),
                      Card(
                        margin:EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          leading: Icon(Icons.local_parking_rounded),
                          title: Text('SENAI'),
                          subtitle: Text('2,4 km'),
                          trailing: ElevatedButton(
                            onPressed: () => {},
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