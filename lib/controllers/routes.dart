import 'package:go_router/go_router.dart';
import 'package:parking/pages/cadastro_page.dart';
import 'package:parking/pages/inicio_page.dart';
import 'package:parking/pages/login_page.dart';
import 'package:parking/pages/maps_page.dart';
import 'package:parking/pages/veiculo_page.dart';
import 'package:parking/repositories/veiculo_repository.dart';

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
      builder: (context, state) => EditarVeiculoPage(veiculoRepository: VeiculoRepository()),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, state) => RegistroPage(),
    ),
  ]
);