import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 10, 168, 160),
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const NavigationExample(),
    );
  }
}

void handleButtonPressed() {
  print('Button pressed');
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  GoogleMapController? mapController;
  final LatLng _center = const LatLng(-12.231149, -38.969271);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Color.fromARGB(255, 29, 29, 29),
        indicatorColor: Color.fromARGB(255, 255, 187, 0),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Color.fromARGB(255, 255, 255, 255)),
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined, color: Color.fromARGB(255, 255, 255, 255)),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: Icon(Icons.car_rental_outlined, color: Color.fromARGB(255, 255, 255, 255)),
            label: 'Vagas',
          ),
        ],
      ),
      body: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 18.0,
          ),
        ),
        
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                'Estacionamentos Próximos',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.local_parking_rounded),
                  title: Text('Shopping Boulevard'),
                  subtitle: Text('1,0 km'),
                  trailing: ElevatedButton(
                    onPressed: handleButtonPressed,
                    child: Text('Detalhes'),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.local_parking_rounded),
                  title: Text('SENAI'),
                  subtitle: Text('2,4 km'),
                  trailing: ElevatedButton(
                    onPressed: handleButtonPressed,
                    child: Text('Detalhes'),
                  ),
                ),
              ),
            ],
          ),
        ),
    
        Card(
          margin: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 1000,
            height: 30,
            child: Center(
              child: Text('oi'),
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}

void main() => runApp(NavigationBarApp());
