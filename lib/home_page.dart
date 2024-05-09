import 'package:flutter/material.dart';
import './components/navigation_bar.dart';

class ParkingManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart-P'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey[900], // Cor de fundo da gaveta lateral
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text('Página Inicial', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Fecha a gaveta lateral
                  // Aqui você pode adicionar a navegação para a página inicial
                },
              ),
              ListTile(
                leading: Icon(Icons.directions_car, color: Colors.white),
                title: Text('Registar Veículo', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Fecha a gaveta lateral
                  // Aqui você pode adicionar a navegação para a página de registro de veículo
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.white),
                title: Text('Histórico de Registros', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Fecha a gaveta lateral
                  // Aqui você pode adicionar a navegação para a página de histórico de registros
                },
              ),
              // Adicione mais itens conforme necessário
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.local_parking,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20.0),
            Text(
              'Bem-vindo ao Sistema de Gerenciamento de Vagas de Estacionamento',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode navegar para outra tela do sistema
              },
              child: Text('Acessar Sistema'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Funcionalidades:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Registre a entrada e saída de veículos'),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Monitore o tempo de permanência dos veículos'),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Calcule taxas de estacionamento'),
            ),
            ListTile(
              leading: Icon(Icons.pie_chart),
              title: Text('Visualize estatísticas de ocupação'),
            ),
          ],
        ),
      ),
            bottomNavigationBar: NavigationBarApp(), 

    );
  }
}