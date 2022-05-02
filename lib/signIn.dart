import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:tp_app/pages/adminPage.dart';

import 'package:tp_app/service/auth.dart';

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
            return const SignScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  AuthService service = AuthService();
  String domain = "@agrimeteo.com";

  final _usernameController = TextEditingController();
  final _passwordControler = TextEditingController();
  final _confPasController = TextEditingController();
  final _nameController = TextEditingController();

//la selection par defaut
  String _type = "Producteur";
  //recuperer la valeur selectionner
  String holder = "";
  List<String> typesUser = [
    'Producteur',
    'Cooperative',
  ];
  void getTypeUser() {
    setState(() {
      holder = _type;
    });
  } //fin variable et fonction dropdownButton

  //checkbox variable
  final auth = FirebaseAuth.instance;
  List<String> categories = [];
  List<String> langues = [];
  List<String> type = [];

  final _tailleController = TextEditingController();

  final _numController = TextEditingController();
  final CollectionReference collectionUtilisateur =
      FirebaseFirestore.instance.collection("utilisateurs");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inscription"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _nameController,

                        decoration: const InputDecoration(
                          hintText: 'Nom Complet?',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(183, 94, 171, 56),
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
                          labelText: 'Nom *',
                          suffixStyle: TextStyle(
                              color: const Color.fromARGB(183, 94, 171, 56)),
                        ),
                        validator: (String? value) {
                          return (value == null || value == "")
                              ? 'Ce champ est obligatoire:'
                              : null;
                        },
                        //onSaved: (val) => name = val!,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropDownMultiSelect(
                        onChanged: (List<String> x) {
                          setState(() {
                            type = x;
                          });
                        },
                        options: const ['Producteur', 'Cooperative'],
                        selectedValues: type,
                        whenEmpty: 'Utilisateur',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _tailleController,
                        decoration: const InputDecoration(
                          hintText: 'Effectif cooperative ?',
                          labelText: 'Taille *',
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
                          hintStyle: TextStyle(
                            color: Color.fromARGB(183, 94, 171, 56),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        validator: (String? value) {
                          return (value == null || value == "")
                              ? 'Ce champ est obligatoire:'
                              : null;
                        },
                      ),
                      /* const SizedBox(
                        height: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text("Selectionnez les Langues"),
                          SizedBox(
                            height: 100,
                            child: ListView(
                              children: values.keys.map((String key) {
                                return CheckboxListTile(
                                  value: values[key],
                                  title: Text(key),
                                  activeColor: Colors.pink,
                                  checkColor: Colors.white,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      values[key] = value!;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: getLangItems,
                              child: const Text(
                                "Cliquer ici après la selection",
                                style: TextStyle(fontSize: 18),
                              )),
                          const Text("Selectionnez les catégorie"),
                          SizedBox(
                            height: 100,
                            child: ListView(
                              children: valeurs.keys.map((String key) {
                                return CheckboxListTile(
                                  value: valeurs[key],
                                  title: Text(key),
                                  activeColor: Colors.pink,
                                  checkColor: Colors.white,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      valeurs[key] = value!;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: getCategItems,
                              child: const Text(
                                "Cliquer Ici après la selection",
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),

                      */
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Identifiant a attribue?',
                          labelText: 'Identifiant *',
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
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(183, 94, 171, 56),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        validator: (String? value) {
                          return (value == null || value == "")
                              ? 'Ce champ est obligatoire:'
                              : null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _numController,
                        decoration: const InputDecoration(
                          hintText: 'numero de telephone?',
                          labelText: 'Contact *',
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
                          hintStyle: TextStyle(
                            color: Color.fromARGB(183, 94, 171, 56),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        validator: (String? value) {
                          return (value == null || value == "")
                              ? 'Ce champ est obligatoire:'
                              : null;
                        },
                        //onSaved: (val) => num = val!,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _passwordControler,
                        decoration: const InputDecoration(
                            hintText: '*********',
                            labelText: 'Code secret *',
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
                            hintStyle: TextStyle(
                              color: Color.fromARGB(183, 94, 171, 56),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                        validator: (String? value) {
                          return (value == null || value == "")
                              ? 'Ce champ est obligatoire:'
                              : null;
                        },
                        // onSaved: (val) => pwd = val!,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _confPasController,
                        decoration: const InputDecoration(
                          hintText: 'confirmer le code?',
                          labelText: 'Confirmation *',
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
                          hintStyle: TextStyle(
                            color: Color.fromARGB(183, 94, 171, 56),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return 'repeter le mot de passe';
                          if (value != _passwordControler.text)
                            return 'ça ne correspond pas';
                          return null;
                        },
                        // onSaved: (val) => conPwd = val!,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {
                                  langues = x;
                                });
                              },
                              options: ['Yoruba', 'Français', 'Fon', 'Adja'],
                              selectedValues: langues,
                              whenEmpty: ' Langues *',
                            ),
                            DropDownMultiSelect(
                              onChanged: (List<String> x) {
                                setState(() {
                                  categories = x;
                                });
                              },
                              options: const [
                                'Maïs',
                                'Riz',
                                'Soja',
                                'Ananas',
                                'Maraichage'
                              ],
                              selectedValues: categories,
                              whenEmpty: ' Filières*',
                            ),
                          ]),
                      SizedBox(
                        height: he * 0.04,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            auth
                                .createUserWithEmailAndPassword(
                                    email: _usernameController.text + domain,
                                    password: _passwordControler.text)
                                .then((value) {
                              FirebaseFirestore.instance
                                  .collection('userData')
                                  .doc(value.user!.uid)
                                  .set({
                                "identifiant": value.user!.email,
                                "nom": _nameController.text,
                                "utilisateur": holder,
                                "numero": _numController.text,
                                "effectif": _tailleController.text,
                                "code": _passwordControler.text,
                                "filieres": categories,
                                "langues": langues
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminScreen()));
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "Utilisateur non enregistrer") {
                              print("Echec d'enregistrement de l'utilisateur");
                            }
                          }
                        },
                        child: const Text('Valider'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,

                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          // shadowColor: Color.fromARGB(183, 35, 98, 3),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}
