import 'package:flutter/material.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';

class ScreenCallWaiter extends StatefulWidget {
  const ScreenCallWaiter({super.key});

  @override
  State<ScreenCallWaiter> createState() => _ScreenCallWaiterState();
}

class _ScreenCallWaiterState extends State<ScreenCallWaiter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}