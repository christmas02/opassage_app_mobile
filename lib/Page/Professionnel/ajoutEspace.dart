import 'dart:ffi';
import 'dart:io';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/model/jour.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AjoutEspace extends StatefulWidget {
  AjoutEspace({Key? key}) : super(key: key);

  @override
  _AjoutEspaceState createState() => _AjoutEspaceState();
}

class _AjoutEspaceState extends State<AjoutEspace> {
  List _listcommune = [];
  final TextEditingController montantcontroller = new TextEditingController();
  final TextEditingController descriptioncontroller =
      new TextEditingController();

  var commune;
  List<Jour> _list = [];

  var time_start;
  var time_end;

  getCheckboxItems() {
    print(_selecteCategorys);

    _selecteCategorys.clear();
  }

  List _selecteCategorys = [];

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
      });
    }
  }

  File? image;
  File? image2;
  File? image3;

  loadCommune() async {
    var response = await dio.get(
      '${lien}/liste_commune',
    );
    var test = response.data['data'];
    setState(() {
      _listcommune = test;
    });
  }

  loadJour() async {
    var response = await dio.get(
      '${lien}/liste_jours',
    );
    var test = response.data['data'];
    setState(() {
      for (var i in test) {
        _list.add(Jour.fromJson(i));
      }
    });
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

  Future pickImage2() async {
    final image2 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image2 == null) return;
    final imageTemporary = File(image2.path);
    this.image2 = imageTemporary;
    setState(() {
      this.image2 = imageTemporary;
    });
  }

  Future pickImage3() async {
    final image3 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image3 == null) return;
    final imageTemporary = File(image3.path);
    this.image3 = imageTemporary;
    setState(() {
      this.image3 = imageTemporary;
    });
  }

  ajout() async {
    var body = {
      "image_un": image,
      "image_deux": image2,
      "image_trois": image3,
      "description": descriptioncontroller.text.trim(),
      "commune": commune,
      'localisation': "",
      'montant': montantcontroller.text.trim(),
      'jousdispo': _selecteCategorys,
      'time_start': time_start,
      'time_end': time_end,
    };
    // print(body);

    http.post(Uri.parse('${lien}/liste_espace_professionnel'), headers: {
      "Content-type": "multipart/form-data",
    }, body: {
      "image_un": image,
      "image_deux": image2,
      "image_trois": image3,
      "description": descriptioncontroller.text.trim(),
      "commune": commune,
      'localisation': "",
      'montant': montantcontroller.text.trim(),
      'jousdispo': _selecteCategorys,
      'time_start': time_start,
      'time_end': time_end,
    }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
  }

  @override
  void initState() {
    super.initState();
    loadCommune();
    loadJour();
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
              controller: descriptioncontroller,
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
              controller: montantcontroller,
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
                    image2 != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.file(
                              image2!,
                              height: 50,
                            ),
                          )
                        : Container(
                            child: Text('Ajouter une Photo '),
                          ),
                    IconButton(
                        onPressed: () {
                          pickImage2();
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
                    image3 != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.file(
                              image3!,
                              height: 50,
                            ),
                          )
                        : Container(
                            child: Text('Ajouter une Photo '),
                          ),
                    IconButton(
                        onPressed: () {
                          pickImage3();
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

          /* Column(
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
           */
          Column(
              children: _list.map((hobby) {
            return CheckboxListTile(
                value: _selecteCategorys.contains(hobby.id),
                title: Text(hobby.libelle.toString()),
                onChanged: (newValue) {
                  _onCategorySelected(newValue!, hobby.id);
                });
          }).toList()),
          RaisedButton(
            child: Text("Choisir heure de disponibilité"),
            onPressed: () => TimeRangePicker.show(
              context: context,
              onSubmitted: (TimeRangeValue value) {
                setState(() {
                  time_start = value.startTime!.hour.toString() +
                      ":" +
                      value.startTime!.minute.toString();
                  time_end = value.endTime!.hour.toString() +
                      ":" +
                      value.endTime!.minute.toString();
                });
                print("${value.startTime} - ${value.endTime}");
              },
            ),
          ),
          time_start == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Heure de disponibilité',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${time_start} - ${time_end}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
          /*  RaisedButton(
            child: Text(
              " Get Selected Checkbox Items ",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: getCheckboxItems,
            color: Colors.deepOrange,
            textColor: Colors.white,
            splashColor: Colors.grey,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          ), */
          Container(
            margin: EdgeInsets.all(10),
            height: 50.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                ajout();
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
