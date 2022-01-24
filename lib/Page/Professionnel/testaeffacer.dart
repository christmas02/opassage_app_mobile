import 'dart:convert';
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
  File? image4;
  File? image5;
  final picker = ImagePicker();

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

  upload() async {
    final uri = Uri.parse('${lien}/save_espace');
    var request = http.MultipartRequest('POST', uri);
    request.fields['description'] = descriptioncontroller.text.trim();
    var pic = await http.MultipartFile.fromPath("image_one", image!.path);
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    print(result);

    /*  http.post(uri, body: {
      "image_one": image!.path,
      /* "image_two": image2,
      "image_thee": image3,
      "image_for": image4,
      "image_five": image5, */
      "description": descriptioncontroller.text.trim(),
      "commune": commune,
      'localisation': "",
      'montant': montantcontroller.text.trim(),
      'jousdispo': _selecteCategorys,
      'time_start': time_start,
      'time_end': time_end,
    }); */
  }

  /* ajout() async {
    /*  var request =
        http.MultipartRequest('POST', Uri.parse('${lien}/save_espace'));
    request.fields['commune'] = commune;
    var pic = await http.MultipartFile.fromPath("image_un", image!.path);
    request.files.add(pic);

    var response = await request.send();
    if (response.statusCode == 200) {
      print('ok');
    } else {
      print('non');
    }
    var body = {
      "image_one": image,
      "image_two": image2,
      "image_thee": image3,
      "image_for": image4,
      "image_five": image5,
      "description": descriptioncontroller.text.trim(),
      "commune": commune,
      'localisation': "",
      'montant': montantcontroller.text.trim(),
      'jousdispo': _selecteCategorys,
      'time_start': time_start,
      'time_end': time_end,
    }; */

    var t = http.post(Uri.parse('${lien}/save_espace'), headers: {
      "Content-type": "multipart/form-data",
    }, body: {
      "image_one": image,
      "image_two": image2,
      "image_thee": image3,
      "image_for": image4,
      "image_five": image5,
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

    print(t);
  }
 */

  ajout() async {
    print('-------------------');
    print('ok');
  }

  /* var body = {
      "image_two": image2,
      "image_thee": image3,
      "image_for": image4,
      "image_five": image5,
      "description": descriptioncontroller.text.trim(),
      "commune": commune,
      'localisation': "",
      'montant': montantcontroller.text.trim(),
      'jousdispo': _selecteCategorys,
      'time_start': time_start,
      'time_end': time_end,
    }; */

/*  var request = http.MultipartRequest(
        "POST", Uri.parse("http://10.0.2.2:8000/api/multiple-image-upload"));
    request.fields["description"] = descriptioncontroller.text.trim();
    request.fields["commune"] = commune;
    request.fields["localisation"] = "";
    request.fields["montant"] = montantcontroller.text.trim();
    for (String item in _selecteCategorys) {
      request.files.add(http.MultipartFile.fromString('jousdispo', item));
    }
    //request.fields["jousdispo"] = _selecteCategorys as String;
    request.fields["time_start"] = time_start;
    request.fields["time_end"] = time_end;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image_one", image!.path);
    var pic2 = await http.MultipartFile.fromPath("image_two", image2!.path);
    var pic3 = await http.MultipartFile.fromPath("image_three", image3!.path);
    var pic4 = await http.MultipartFile.fromPath("image_four", image4!.path);
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
    print(responseString); */
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
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: 'Designation',
              hintText: 'Designation',
            ),
          ),
          TextField(
            controller: descriptioncontroller,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: 'Description',
              hintText: 'Description',
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.all(10),
            child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: 'selectionnez',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: 'Localisation',
              hintText: 'Localisation',
            ),
          ),
          TextField(
            controller: montantcontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              labelText: 'Montant à l\heure',
              hintText: 'Montant à l\heure',
            ),
          ),
          Text(
            'Galerie',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          /*   Spacer(), */

          Container(
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: Expanded(
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
              )),
          Container(
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
          Container(
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
          Container(
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
          Container(
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
          Text(
            'Disponibilité',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                print('ok');
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
