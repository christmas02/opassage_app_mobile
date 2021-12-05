import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Connexion/connexion.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = new TextEditingController();
  var chargement = false;
  _modif() async {
    var data = {
      "email": _emailController.text,
    };
    final response = await dio.post('${lien}/save_password_forget', data: data);
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
                      'un mail vous a été envoyé ',
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          ('Mots de passe oublié'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
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
                  _modif();
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
