import 'package:flutter/material.dart';
import 'package:konoeki_de_oritimer/screens/alert/_oritimer_dialog.dart';
import 'package:konoeki_de_oritimer/screens/alert/train_select_alert.dart';

import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
              },
              child: const Text('click'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                OritimerDialog(
                  context: context,
                  widget: TrainSelectAlert(),
                );
              },
              child: const Text('station'),
            ),
          ],
        ),
      ),
    );
  }
}
