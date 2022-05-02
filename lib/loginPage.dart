import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:tp_app/pages/profileScreen.dart';
import 'package:tp_app/service/auth.dart';

import 'package:tp_app/util/background.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  //initialisation
  Future<FirebaseApp> _initialisefirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initialisefirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String domain = "@agrimeteo.com";
  bool _laoding = true;
  /* static Future<User?> logUsingUsernamePassword(
      {required String userId,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: userId, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Aucun utilisateur avec cet identifiant");
      }
    }
    return user;
  }
*/
  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Inscription"),
            content:
                const Text("Contacter nous au +22966154804 pour l'inscription"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  AuthService service = AuthService();
  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordControler = TextEditingController();
    //AuthService authService = Provider.of<AuthService>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Background(
              height: 446.0,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 29.0, right: 10),
                            child: Image.asset(
                              'assets/images/agri2.png',
                              height: 150,
                              width: 125,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Form(
                          child: Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32, top: 90),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: const TextSpan(
                                      children: <TextSpan>[
                                        /*TextSpan(
                                            text: 'Connecter vous',
                                            
                                            ),
                                          ),*/
                                        TextSpan(
                                          text: 'Identifiant',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                183, 94, 171, 56),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    child: TextField(
                                      controller: _usernameController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'azoveC203',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFBABABA),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFBEC5D1),
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFBEC5D1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.right,
                                    text: const TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Code secret',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                183, 94, 171, 56),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  SizedBox(
                                    height: 45,
                                    child: TextField(
                                      controller: _passwordControler,
                                      autocorrect: false,
                                      enableSuggestions: false,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: '************',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFBABABA),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFBEC5D1),
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFBEC5D1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 200, right: 0, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            _showDialog(context);
                                          },
                                          child: const Text(
                                            'S\'inscrire',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    183, 94, 171, 56)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                            height: 50,
                            minWidth: 285,
                            color: const Color.fromARGB(183, 94, 171, 56),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            onPressed: () async {
                              String email = "";
                              if (_usernameController.text.isNotEmpty &&
                                  _passwordControler.text.isNotEmpty) {
                                email = _usernameController.text + domain;
                                service.loginUser(
                                    context, email, _passwordControler.text);
                              } else
                                service.errorBox(
                                    context, 'Remplissez tous les champs svp');
                            }),
                        const SizedBox(
                          width: 5.0,
                        ),
                        _laoding
                            ? const CircularProgressIndicator(
                                color: Colors.cyan,
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
