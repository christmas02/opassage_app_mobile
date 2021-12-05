import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Connexion/forgetpassword.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/main.dart';
import 'package:opassage_app/utilities/color.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Connexion extends StatefulWidget {
  Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var chargement = false;
  _login() async {
    var dio = Dio();
    var data = {
      'email': _emailController.text.trim().toLowerCase(),
      'password': _passwordController.text.trim().toLowerCase(),
    };

    final response =
        await dio.post('${lien}/authentification/login', data: data);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('name', response.data['user']['name']);
    localStorage.setInt('id', response.data['user']['id']);
    localStorage.setString('email', response.data['user']['email']);
    localStorage.setInt('role', response.data['role']);

    if (response.data['statu'] == 1) {
      setState(() {
        chargement = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {}
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
          ('Connexion'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 30),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'Adresse electronique',
                    hintText: 'Adresse electronique',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'Mots de passe',
                    hintText: 'Mots de passe',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Text('Mots de passe oublié ?')),
                  )
                ],
              ),
              chargement == true
                  ? CircularProgressIndicator()
                  : Container(
                      margin: EdgeInsets.all(10),
                      height: 50.0,
                      width: 200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          /*   setState(() {
                            chargement = true;
                          }); */
                          _login();
                        },
                        padding: EdgeInsets.all(10.0),
                        color: violet,
                        textColor: Color.fromRGBO(255, 255, 255, 1),
                        child:
                            Text("Connexion", style: TextStyle(fontSize: 15)),
                      ),
                    ),
            ],
          )),
    );
  }
}
