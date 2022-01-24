import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opassage_app/Page/profil.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModifEspace extends StatefulWidget {
  final int id;
  final String name;
  final String montant;
  final String description;
  final String localisation;
  final String matricule;
  ModifEspace(
      {Key? key,
      required this.matricule,
      required this.name,
      required this.montant,
      required this.description,
      required this.localisation,
      required this.id})
      : super(key: key);

  @override
  _ModifEspaceState createState() => _ModifEspaceState();
}

class _ModifEspaceState extends State<ModifEspace> {
  List _listcommune = [];
  List _listtype = [];
  var commune;
  var type;

  final TextEditingController montantcontroller = new TextEditingController();
  final TextEditingController descriptioncontroller =
      new TextEditingController();
  final TextEditingController designationcontroller =
      new TextEditingController();
  final TextEditingController localisationcontroller =
      new TextEditingController();

//fonction chargement de commune
  loadCommune() async {
    var response = await dio.get(
      '${lien}/liste_commune',
    );
    var test = response.data['data'];
    setState(() {
      _listcommune = test;
    });
  }

  modification() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = localStorage.getInt('id');
    var dio = Dio();
    var data = {
      "id": id,
      "designation": designationcontroller.text.trim(),
      "description": descriptioncontroller.text.trim(),
      "localisation": "cocody",
      "commune": commune,
      "longitude": "0000",
      "latitude": "000000",
      "type": type,
      "montant": montantcontroller.text.trim(),
    };

    final response = await dio.post('${lien}/update_info_espace', data: data);
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
                      ' echec !!! veuillez verifier les informations renseignées',
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

//Fonction chargement de type
  loadtype() async {
    var response = await dio.get('${lien}/liste_categorie');
    var type = response.data['data'];
    setState(() {
      _listtype = response.data['data'];
    });
  }

  @override
  void initState() {
    descriptioncontroller.text = widget.description;
    super.initState();
    loadCommune();
    loadtype();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Modifier  espace  ${widget.name}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: designationcontroller..text = widget.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'Designation',
                hintText: 'Designation',
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: descriptioncontroller..text = widget.description,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: 'Description',
                  hintText: 'Description',
                ),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: localisationcontroller..text = widget.localisation,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'localisation',
                hintText: 'localisation',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.all(10),
              child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'selectionnez',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                value: commune,
                items: _listcommune
                    .map((label) => DropdownMenuItem(
                          child: Text(label['libelle']),
                          value: label['id'],
                        ))
                    .toList(),
                hint: Text('Commune'),
                onChanged: (value) {
                  setState(() {
                    commune = value!;
                  });
                },
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.all(10),
              child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'selectionnez',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                value: type,
                items: _listtype
                    .map((label) => DropdownMenuItem(
                          child: Text(label['libelle']),
                          value: label['id'],
                        ))
                    .toList(),
                hint: Text('Type'),
                onChanged: (value) {
                  setState(() {
                    type = value!;
                  });
                },
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: montantcontroller..text = widget.montant,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'Montant à l\heure',
                hintText: 'Montant à l\heure',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 50.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                // FS();
                modification();
              },
              padding: EdgeInsets.all(10.0),
              color: violet,
              textColor: Color.fromRGBO(255, 255, 255, 1),
              child: Text("Enregistrer", style: TextStyle(fontSize: 15)),
            ),
          )
        ],
      ),
    );
  }
}
