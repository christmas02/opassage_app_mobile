import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Connexion/connexion.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Inscription extends StatefulWidget {
  Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _numeroController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _cpasswordController =
      new TextEditingController();
  final TextEditingController _situationgeoController =
      new TextEditingController();

  var chargement = false;
  var _passwordVisible;
  var _cpasswordVisible;

  _register() async {
    var dio = Dio();

    var data = {
      'name': _nameController.text.trim().toLowerCase(),
      'email': _emailController.text.trim().toLowerCase(),
      'password': _passwordController.text.trim().toLowerCase(),
      'password_confirmation': _cpasswordController.text.trim().toLowerCase(),
      'phone': _numeroController.text.trim().toLowerCase(),
      'role': 1
    };
    print(data);
    try {
      final response =
          await dio.post('${lien}/authentification/register', data: data);

      SharedPreferences localStorage = await SharedPreferences.getInstance();

      localStorage.setInt('role', response.data['role']);
      if (response.data['statu'] == 1) {
        setState(() {
          chargement = false;
        });
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Inscription faite avec succès',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Connexion()));
                        },
                        child: Text('ok'),
                      )
                    ],
                  ),
                ),
              );
            });
      } else {
        print('non');
        setState(() {
          chargement = false;
        });
      }
      print(response.data);
    } catch (e) {
      print(e);
      setState(() {
        chargement = false;
      });
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 100,
              color: Colors.red,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'veuillez verifier les informations renseignées',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          });
      print(e);
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
    _cpasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          ('Inscription'),
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Nom et prenom',
                  hintText: 'Nom et prenom',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Adresse email',
                  hintText: 'Adresse email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _numeroController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Numero de telephone',
                  hintText: 'Numero de telephone',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 5, left: 15, right: 15),
              child: TextField(
                obscureText: !_passwordVisible,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      !_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Mots de passe',
                  hintText: 'Mots de passe',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15, left: 15),
              child: Text(
                '8 caractères minimum',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                obscureText: !_cpasswordVisible,
                controller: _cpasswordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      !_cpasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _cpasswordVisible = !_cpasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Confimation Mots de passe',
                  hintText: 'Confimation Mots de passe',
                ),
              ),
            ),
            chargement
                ? CircularProgressIndicator()
                : Container(
                    margin: EdgeInsets.all(10),
                    height: 50.0,
                    width: 150,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        setState(() {
                          chargement = true;
                        });
                        _register();
                      },
                      padding: EdgeInsets.all(10.0),
                      color: violet,
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      child:
                          Text("Inscription", style: TextStyle(fontSize: 15)),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
