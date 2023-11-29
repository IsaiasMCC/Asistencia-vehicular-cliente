import 'package:asistencia_vehicular_cliente/presentation/blocs/loca_storage_bloc/local_storage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<CardInfo> cardInfoList = [
    CardInfo(
        icon: Icons.car_repair,
        title: 'Gestionar Vehiculo',
        color: Colors.blue,
        route: '/car/list'),
    CardInfo(
        icon: Icons.swipe_up_outlined,
        title: 'Asistencia',
        color: Colors.green,
        route: '/asistencia'),
    CardInfo(
        icon: Icons.attach_money_outlined,
        title: 'Pagos',
        color: Colors.orange,
        route: '/pagos/historial'),
    CardInfo(
        icon: Icons.person_outline_sharp,
        title: 'Perfil',
        color: Colors.red,
        route: '/profile'),
    // Agrega más objetos CardInfo según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    final localStorageBloc = context.watch<LocalStorageBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                bool ok = await localStorageBloc.dropUser();
                if (ok) {
                  Future.microtask(() {
                    context.pushReplacement('/login');
                  });
                }
              })
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas en la cuadrícula
        ),
        itemCount: cardInfoList.length,
        itemBuilder: (context, index) {
          final cardInfo = cardInfoList[index];
          return GestureDetector(
            onTap: () {
              // Acción a realizar al hacer clic en la tarjeta (puedes personalizar esto)
              context.pushNamed(cardInfo.route);
            },
            child: CardItem(
              icon: cardInfo.icon,
              title: cardInfo.title,
              color: cardInfo.color,
            ),
          );
        },
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const CardItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, // Color de fondo de la tarjeta
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white, // Color del ícono
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20), // Color del texto del título
          ),
        ],
      ),
    );
  }
}

class CardInfo {
  final IconData icon;
  final String title;
  final Color color;
  final String route;

  CardInfo(
      {required this.icon,
      required this.title,
      required this.color,
      required this.route});
}
