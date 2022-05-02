import 'package:flutter/material.dart';
import 'package:tp_app/pages/loginPage.dart';
import 'package:tp_app/pages/signIn.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(' ADMIN'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                tooltip: 'Enregistrer un Utilisateur',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignScreen(),
                        fullscreenDialog: true,
                      ));
                }),
          ],
        ),
        body: Container(child: Text('ADMIN')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (() => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
                fullscreenDialog: true,
              ))),
          backgroundColor: Colors.green,
          label: Text('LOG OUT'),
          icon: Icon(Icons.logout),
        ));
  }
}
