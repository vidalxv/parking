import 'package:go_router/go_router.dart';
import 'package:parking/pages/inicio_page.dart';
import 'package:parking/pages/maps_page.dart';

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
  ]
);