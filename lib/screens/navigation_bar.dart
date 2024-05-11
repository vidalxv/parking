import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../themes/theme.dart';

void main() {
  runApp(NavigationBarApp());
}

class NavigationBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme,
      home: NavigationExample(),
    );
  }
}

void handleButtonPressed() {
  print('Button pressed');
}

class NavigationExample extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar( 
        leading: Icon(Icons.car_crash),
        title: const Text('Inicio',
        ),
        backgroundColor: Color.fromARGB(255, 247, 245, 245),
        ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Color.fromARGB(255, 29, 29, 29),
        indicatorColor: Color.fromARGB(255, 255, 187, 0),
        selectedIndex: currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.map, color: Colors.white),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: Icon(Icons.car_rental_outlined, color: Colors.white),
            label: 'Vagas',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          Scaffold(
            body: Column(
              children: [
                Container(
                  margin:EdgeInsets.symmetric(vertical: 10.0),
                ),
                Card(
                  color: Color.fromARGB(255, 17, 17, 17),
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
                            color: Colors.white
                            ),
                          ),
                        subtitle: Text(
                          'PCG-4234',
                          textAlign: TextAlign.center
                          , style: TextStyle(
                            color: Colors.white
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
                        margin:EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
              ],
            ),
          ),

          // Tela 2: Mapa do Google
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18.0,
            ),
          ),

          // Tela 3: 
          Center(
            child: Text(
              'oi',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Color backgroundColor;
  final Color indicatorColor;

  const NavigationBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.backgroundColor,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      selectedItemColor: indicatorColor,
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: destination.icon,
          label: destination.label,
          activeIcon: destination.selectedIcon,
        );
      }).toList(),
    );
  }
}

class NavigationDestination {
  final Widget icon;
  final Widget? selectedIcon;
  final String label;

  const NavigationDestination({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}
