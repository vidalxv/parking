import 'package:go_router/go_router.dart';
import 'package:parking/pages/inicio_page.dart';
import 'package:parking/pages/login_page.dart';
import 'package:parking/pages/maps_page.dart';
import 'package:parking/pages/veiculo_page.dart';

final routes = GoRouter (
  routes : [
    GoRoute(
      path: '/',
      builder: (context, state) => InicioPage(),
      ),
    GoRoute(
      path: '/mapa',
      builder: (context, state) => const MapsPage(),
    ),
    GoRoute(
      path: '/veiculo',
      builder: (context, state) => EditarVeiculoPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    )
  ]
);