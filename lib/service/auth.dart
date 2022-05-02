import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp_app/pages/adminPage.dart';
import 'package:tp_app/pages/profileScreen.dart';
import 'package:tp_app/pages/signUpdate.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  void createUser(
    context,
    email,
    password,
    nom,
    type,
    number,
    taille,
  ) {
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance
            .collection('userData')
            .doc(value.user!.uid)
            .set({
          "identifiant": value.user!.email,
          "nom": nom,
          "utilisateur": type,
          "numero": number,
          "effectif": taille,
          "code": password
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpdate()));
      });

      /*Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminScreen())));*/
    } catch (e) {
      errorBox(context, e);
    }
  }

  void loginUser(context, email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                if (email != 'honvo@agrimeteo.com')
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()))
                  }
                else
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminScreen()))
                  }
              });
    } catch (e) {
      errorBox(context, e);
    }
  }

  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erreur"),
            content: Text(e.toString()),
          );
        });
  }
}
