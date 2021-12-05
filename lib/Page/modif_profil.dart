import 'package:flutter/material.dart';
import 'package:opassage_app/Page/profil.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Modif_profil extends StatefulWidget {
  Modif_profil({Key? key}) : super(key: key);

  @override
  _Modif_profilState createState() => _Modif_profilState();
}

class _Modif_profilState extends State<Modif_profil> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _nomController = new TextEditingController();
  final TextEditingController _phoneContoller = new TextEditingController();
  var chargement = false;

  valider() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = localStorage.getInt('id');
    var data = {
      "id_user": id,
      "name": _nomController.text,
      "email": _emailController.text,
      "phone": _phoneContoller.text,
    };

    print(data);
    final response = await dio.post('${lien}/update_profile', data: data);

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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profil()));
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
          ('Modification Profil'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
                child: TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'nom',
                    hintText: 'nom',
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
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
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
                child: TextFormField(
                  controller: _phoneContoller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'numero de telephone',
                    hintText: 'numero de telephone',
                  ),
                ),
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
                          valider();
                        },
                        padding: EdgeInsets.all(10.0),
                        color: violet,
                        textColor: Color.fromRGBO(255, 255, 255, 1),
                        child: Text("valider", style: TextStyle(fontSize: 15)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
