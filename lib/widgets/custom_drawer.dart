import 'package:expense_diary/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                signOut(context);
              },
              child: const Text('Sign Out'))
        ],
      ),
    ));
  }
}
