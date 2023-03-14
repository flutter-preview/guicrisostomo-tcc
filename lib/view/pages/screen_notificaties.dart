import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';

class ScreenNotifications extends StatefulWidget {
  const ScreenNotifications({super.key});

  @override
  State<ScreenNotifications> createState() => _ScreenNotificationsState();
}

class _ScreenNotificationsState extends State<ScreenNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Notificações', context: context, withoutIcons: true,
      ),

      body: const ListTile(
        title: Text(
          'Notificação 1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          'Descrição da notificação 1',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),

        trailing: Icon(
          Icons.notifications_active,
          size: 30,
        ),
      ),
    );
  }
}