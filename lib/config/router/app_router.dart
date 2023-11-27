import 'package:asistencia_vehicular_cliente/presentation/screens/screens.dart';
import 'package:asistencia_vehicular_cliente/presentation/screens/tecnico/home_tecnico_screen.dart';
import 'package:asistencia_vehicular_cliente/presentation/screens/tecnico/lista_task_screen.dart';

import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  // initialLocation: '/login',
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: '/login',
      builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
      path: '/register',
      name: '/register',
      builder: (context, state) => const RegisterScreen()
    ),
    GoRoute(
      path: '/car/register',
      name: '/car/register',
      builder: (context, state) => const RegisterCarScreen()
    ),
    GoRoute(
      path: '/asistencia',
      name: '/asistencia',
      builder: (context, state) => const AsistenciaScreen()
    ),
    GoRoute(
      path: '/pagos/historial',
      name: '/pagos/historial',
      builder: (context, state) => const PagoHistorialScreen()
    ),
    GoRoute(
      path: '/profile',
      name: '/profile',
      builder: (context, state) => const ProfileScreen()
    ),
     GoRoute(
      path: '/task',
      name: '/task',
      builder: (context, state) => const TaskScreen()
    ),
      GoRoute(
      path: '/homeTaller',
      name: '/homeTaller',
      builder: (context, state) => const TecnicoHome()
    ),
  ]
);