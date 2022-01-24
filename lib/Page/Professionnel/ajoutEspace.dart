import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opassage_app/Page/Connexion/forgetpassword.dart';
import 'package:opassage_app/Page/profil.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/model/jour.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:http/http.dart' as http;

class AjoutEspace extends StatefulWidget {
  AjoutEspace({Key? key}) : super(key: key);

  @override
  _AjoutEspaceState createState() => _AjoutEspaceState();
}

class _AjoutEspaceState extends State<AjoutEspace> {
  List _listcommune = [];
  List _listtype = [];
  final TextEditingController montantcontroller = new TextEditingController();
  final TextEditingController descriptioncontroller =
      new TextEditingController();
  final TextEditingController designationcontroller =
      new TextEditingController();
  final TextEditingController localisationcontroller =
      new TextEditingController();
  var commune;
  var type;
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
  File? image4;
  File? image5;
  final picker = ImagePicker();
  var id;

  loadCommune() async {
    var response = await dio.get(
      '${lien}/liste_commune',
    );
    var test = response.data['data'];
    setState(() {
      _listcommune = test;
    });
  }

  loadtype() async {
    var response = await dio.get('${lien}/liste_categorie');
    var type = response.data['data'];
    setState(() {
      _listtype = response.data['data'];
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

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage as File?;
    });
  }

  Future pickImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
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

  Future pickImage4() async {
    final image4 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image4 == null) return;
    final imageTemporary = File(image4.path);
    this.image4 = imageTemporary;
    setState(() {
      this.image4 = imageTemporary;
    });
  }

  Future pickImage5() async {
    final image5 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image5 == null) return;
    final imageTemporary = File(image5.path);
    this.image5 = imageTemporary;
    setState(() {
      this.image5 = imageTemporary;
    });
  }

  T() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      id = localStorage.getInt('id');
    });
    var body = {
      "image_one": image,
      "image_two": image2,
      "image_three": image3,
      "image_for": image4,
      "image_five": image5,
      "description": descriptioncontroller.text.trim(),
      "commune": commune,
      'localisation': "",
      'montant': montantcontroller.text.trim(),
      'jourdispo': _selecteCategorys,
      'time_start': time_start,
      'time_end': time_end,
      'id': id
    };

    /* var request = http.MultipartRequest(
        "POST", Uri.parse("http://10.0.2.2:8000/api/multiple-image-upload")); */
    var request =
        http.MultipartRequest("POST", Uri.parse("${lien}/save_espace"));
    request.fields["id"] = "10";
    request.fields['designation'] = designationcontroller.text.trim();
    request.fields["description"] = descriptioncontroller.text.trim();
    request.fields["commune"] = commune.toString();
    request.fields["localisation"] = localisationcontroller.text.trim();
    request.fields["montant"] = montantcontroller.text.trim();

    for (int i = 0; i < _selecteCategorys.length; i++) {
      request.fields['jousdispo[$i]'] = '${_selecteCategorys[i]}';
    }

    ///
    ///

    ///

    //request.fields["jousdispo"] = _selecteCategorys;
    /* for (int item in _selecteCategorys) {
      request.files
          .add(http.MultipartFile.fromString('jousdispo', item.toString()));
    } */
    //
    request.fields["time_start"] = '14:00';
    request.fields["time_end"] = '15:12';
    request.fields['longitude'] = "124";
    request.fields['latitude'] = "457";
    request.fields['type'] = type.toString();

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image_one", image!.path);
    var pic2 = await http.MultipartFile.fromPath("image_two", image2!.path);
    var pic3 = await http.MultipartFile.fromPath("image_thee", image3!.path);
    var pic4 = await http.MultipartFile.fromPath("image_for", image4!.path);
    var pic5 = await http.MultipartFile.fromPath("image_five", image3!.path);
    //add multipart to request
    request.files.add(pic);
    request.files.add(pic2);
    request.files.add(pic3);
    request.files.add(pic4);
    request.files.add(pic5);

    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print('-------------');
    print(responseString);
    print(response.statusCode);
    if (response.statusCode == 200) {
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
                      'succès',
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
                      'veuillez verifier les informations renseignées',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    //print(body);
  }

  void FS() async {
    FormData formData = FormData.fromMap({
      "name": "wendux",
      "age": 25,
      "other": _selecteCategorys,
    });
    Dio dio = new Dio();

    dio
        .post("http://10.0.2.2:8000/api/multiple-image-upload", data: formData)
        .then((response) {
      print(response);
    }).catchError((error) => print(error));
  }

  @override
  void initState() {
    super.initState();
    loadCommune();
    loadJour();
    loadtype();
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
              controller: designationcontroller,
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
              )),
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
              controller: localisationcontroller,
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
            padding: EdgeInsets.all(10),
            child: Text(
              'Galerie',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
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
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
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
            padding: EdgeInsets.all(10),
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
            padding: EdgeInsets.all(10),
            child: Container(
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    image4 != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.file(
                              image4!,
                              height: 50,
                            ),
                          )
                        : Container(
                            child: Text('Ajouter une Photo '),
                          ),
                    IconButton(
                        onPressed: () {
                          pickImage4();
                        },
                        icon: Icon(Icons.photo))
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    image5 != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.file(
                              image5!,
                              height: 50,
                            ),
                          )
                        : Container(
                            child: Text('Ajouter une Photo '),
                          ),
                    IconButton(
                        onPressed: () {
                          pickImage5();
                        },
                        icon: Icon(Icons.photo))
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Disponibilité',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
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
          Container(
            margin: EdgeInsets.all(10),
            height: 50.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                // FS();
                T();
              },
              padding: EdgeInsets.all(10.0),
              color: violet,
              textColor: Color.fromRGBO(255, 255, 255, 1),
              child: Text("Enregistrer", style: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
