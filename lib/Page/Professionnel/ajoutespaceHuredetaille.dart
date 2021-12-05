import 'dart:ffi';
import 'dart:io';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/model/jour.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AjoutEspace extends StatefulWidget {
  AjoutEspace({Key? key}) : super(key: key);

  @override
  _AjoutEspaceState createState() => _AjoutEspaceState();
}

class _AjoutEspaceState extends State<AjoutEspace> {
  List _listcommune = [];
  bool _isChecked = true;
  List<String> _listJour = [];

  var commune;
  List<Jour> _list = [];
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

  File? image;
  loadCommune() async {
    var response = await dio.get(
      'http://opassage.impactafric.com/api/liste_commune',
    );
    var test = response.data['data'];
    setState(() {
      _listcommune = test;
    });
  }

  loadJour() async {
    var response = await dio.get(
      'http://opassage.impactafric.com/api/liste_jours',
    );
    var test = response.data['data'];
    setState(() {
      for (var i in test) {
        _list.add(Jour.fromJson(i));
        // loading = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadCommune();
    loadJour();
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    setState(() {
      this.image = imageTemporary;
    });
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
          'Ajouter un espace',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    'Vous devez renseigner tous les champs du formulaires, ils sont obligatoire'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 15),
            child: Text(
              'Information génerale',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
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
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'Description',
                hintText: 'Description',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0, right: 0),
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
                          value: label['libelle'],
                        ))
                    .toList(),
                hint: Text('selectionnez'),
                onChanged: (value) {
                  setState(() {
                    commune = value!;
                  });
                },
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 5, left: 15, right: 15),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'Localisation',
                hintText: 'Localisation',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: 'Montant à l\heure',
                hintText: 'Montant à l\heure',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              'Galerie',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 15, left: 15),
            child: Container(
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    image != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.file(
                              image!,
                              height: 50,
                            ),
                          )
                        : Container(
                            child: Text('Ajouter une Photo '),
                          ),
                    IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(Icons.photo))
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 15, left: 15),
            child: Container(
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    image != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.file(
                              image!,
                              height: 50,
                            ),
                          )
                        : Container(
                            child: Text('Ajouter une Photo '),
                          ),
                    IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(Icons.photo))
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 15, left: 15),
            child: Container(
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    image != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.file(
                              image!,
                              height: 50,
                            ),
                          )
                        : Container(
                            child: Text('Ajouter une Photo '),
                          ),
                    IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(Icons.photo))
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              'Disponibilité',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListView(
            children: values.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(key),
                value: values[key],
                onChanged: (bool? value) {
                  setState(() {
                    values[key] = value!;
                  });
                },
              );
            }).toList(),
          ),
          RaisedButton(
            child: Text(
              " Get Selected Checkbox Items ",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: getCheckboxItems,
            color: Colors.deepOrange,
            textColor: Colors.white,
            splashColor: Colors.grey,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 50.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                debugPrint(values.toString());
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
