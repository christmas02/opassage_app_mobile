import 'package:flutter/material.dart';
import 'package:opassage_app/Page/profil.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/main.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordUpdate extends StatefulWidget {
  PasswordUpdate({Key? key}) : super(key: key);

  @override
  _PasswordUpdateState createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  var _passwordController = TextEditingController();
  var _confpasswordl = TextEditingController();

  changer() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = localStorage.getInt('id');
    if (_passwordController.text == _confpasswordl.text) {
      var data = {
        "id_user": id,
        "password": _passwordController.text,
      };
      final response = await dio.post('${lien}/update_password', data: data);
      if (response.data['statu'] == 1) {
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
                        'modification faite avec succès',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profil()));
                        },
                        child: Text('ok'),
                      )
                    ],
                  ),
                ),
              );
            });
      }
    } else {
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
                      'echec de la demande',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          });
    }
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
                        Profil())) //Navigator.of(context).pop(),
            ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          ('Modification mots de passe'),
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 30),
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
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
              child: TextFormField(
                controller: _confpasswordl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Confirmation mots de passe ',
                  hintText: 'Confirmation mots de passe',
                ),
              ),
            ),
            Container(
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
                  changer();
                },
                padding: EdgeInsets.all(10.0),
                color: violet,
                textColor: Color.fromRGBO(255, 255, 255, 1),
                child: Text("envoyer", style: TextStyle(fontSize: 15)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
