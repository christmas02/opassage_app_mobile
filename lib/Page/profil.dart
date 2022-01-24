import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Connexion/connexion.dart';
import 'package:opassage_app/Page/Inscription/inscription.dart';
import 'package:opassage_app/Page/Inscription/professionnel.dart';
import 'package:opassage_app/Page/Professionnel/ListeEspace.dart';
import 'package:opassage_app/Page/Professionnel/ListeReservation.dart';
import 'package:opassage_app/Page/Professionnel/ajoutEspace.dart';
import 'package:opassage_app/Page/Professionnel/ajoutespaceHuredetaille.dart';
import 'package:opassage_app/Page/Professionnel/scancode.dart';
import 'package:opassage_app/Page/Professionnel/walletbanque.dart';
import 'package:opassage_app/Page/modif_profil.dart';
import 'package:opassage_app/Page/password_update.dart';
import 'package:opassage_app/main.dart';
import 'package:opassage_app/utilities/color.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  var name;
  var id;
  var role;

  data() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      id = localStorage.getInt('id');
      role = localStorage.getInt('role');
    });
    print('-------id------');
    print(id);
  }

  void initState() {
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage())) //Navigator.of(context).pop(),
            ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          ('Profil'),
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: name != null
          ? Container(
              child: role == 2
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.deepPurple,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text('image'),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Modif_profil()));
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 15),
                            child: Text(
                              'Menus',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AjoutEspace()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Ajouter un espace ou une chambre',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListEspace()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Liste des espaces ou chambre',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListeReservationPro()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Liste des reservations',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScanCode()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Scanner un code QR',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WalletBanque()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Wallet Banque',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PasswordUpdate()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Modifier mots de passe',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences localStorage =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                localStorage.clear();
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Deconnexion',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.deepPurple,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container() // Text('image'),
                                    ),
                                Column(
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Cocody lycée technique',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      '+225 000000',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Modif_profil()));
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 15),
                            child: Text(
                              'Menus',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PasswordUpdate()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Modifier mots de passe',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences localStorage =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                localStorage.clear();
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            },
                            child: Container(
                              width: 1000,
                              child: Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Deconnexion',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    )

              /*premier profil  Container(
                      width: MediaQuery.of(context).size.height / 2,
                      height: MediaQuery.of(context).size.height,
                      color: violet,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                () {};
                                child:
                                Container(
                                  child: Container(
                                    width: 1000,
                                    child: Card(
                                        child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Modification mots de passe',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )),
                                  ),
                                );
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  localStorage.clear();
                                });
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new MyHomePage()));
                                ;
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Row(
                                  children: [
                                    Text('Deconnexion',
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )) */
              )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('Se connecter',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18)),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 50.0,
                    width: 150,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Connexion()));
                      },
                      padding: EdgeInsets.all(10.0),
                      color: violet,
                      textColor: blanc,
                      child: Text("Connexion", style: TextStyle(fontSize: 15)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text('S\'inscrire',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18)),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50.0,
                        width: 150,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Inscription()));
                          },
                          padding: EdgeInsets.all(10.0),
                          color: violet,
                          textColor: Color.fromRGBO(255, 255, 255, 1),
                          child: Text("Particulier",
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50.0,
                        width: 150,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Professionnel()));
                          },
                          padding: EdgeInsets.all(10.0),
                          color: violet,
                          textColor: Color.fromRGBO(255, 255, 255, 1),
                          child: Text("Professionnel",
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
