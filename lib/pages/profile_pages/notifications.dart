import 'package:flutter/material.dart';
import 'package:petmarket_bo_app/constants/app_constants.dart';

class NotificationOptionsPage extends StatefulWidget {
  static String routeName = '/notification_options';
  const NotificationOptionsPage({super.key});

  @override
  State<NotificationOptionsPage> createState() => _NotificationOptionsPageState();
}

class _NotificationOptionsPageState extends State<NotificationOptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // Appbar
      appBar: AppBar(
        title: const Text('Opciones de notificaciones'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          // Notificaciones de ordenes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ordenes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Notificaciones de envio de ordenes, recordatiorios y mas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Switch
          SwitchListTile(
            tileColor: Colors.white,
            title: const Text('Notificaciones de ordenes'),
            value: true,
            onChanged: (value) {},
          ),
          SizedBox(
            height: 30,
          ),
          // Notificaciones de promociones
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Promocional',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Recordatorios de promociones, ofertas y mas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Promotions Switch
          SwitchListTile(
            tileColor: Colors.white,
            title: const Text('Notificaciones de promociones'),
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
