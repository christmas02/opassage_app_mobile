import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Professionnel/ListeEspace.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:opassage_app/widget/buildImage.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class DetailEspace extends StatefulWidget {
  final int id;
  final String name;
  final String montant;
  final String description;
  final String localisation;
  final String matricule;
  DetailEspace(
      {Key? key,
      required this.matricule,
      required this.name,
      required this.montant,
      required this.description,
      required this.localisation,
      required this.id})
      : super(key: key);

  @override
  _DetailEspaceState createState() => _DetailEspaceState();
}

class _DetailEspaceState extends State<DetailEspace> {
  final urlImages = [
    'https://www.usine-digitale.fr/mediatheque/3/9/8/000493893_homePageUne/hotel-c-o-q-paris.jpg',
    'https://mobile-img.lpcdn.ca/lpca/924x/acfeefae/88f28a8a-3b0b-11eb-a88b-02fe89184577.jpg',
    'https://mobile-img.lpcdn.ca/lpca/924x/acfeefae/88f28a8a-3b0b-11eb-a88b-02fe89184577.jpg'
  ];
  delete() async {
    var dio = Dio();

    var data = {
      'id': widget.id,
    };

    try {
      final response = await dio.post('${lien}/delete_espaces', data: data);
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
                      'Suppression faite avec succès',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListEspace()));
                      },
                      child: Text('ok'),
                    )
                  ],
                ),
              ),
            );
          });
    } catch (e) {
      print(e);
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
                      'echec de la suppression',
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
        body: ListView(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black, width: 0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                        child: CarouselSlider.builder(
                      options:
                          CarouselOptions(height: 280, viewportFraction: 1),
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = urlImages[index];
                        return buildImage(urlImage, index);
                      },
                    )),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ],
            )),
        SizedBox(
          height: 10,
        ),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.localisation,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                )
              ],
            )),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Disponibilité'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.alarm,
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        color: violet,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(widget.description),
              )
            ],
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Itinéraire',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Montant', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                widget.montant + ' ' + 'XOF',
                style: TextStyle(
                    color: violet, fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Expanded(
            child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              width: 150,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  /* setState(() {
                          chargement = true;
                        });
                        _register(); */
                },
                padding: EdgeInsets.all(10.0),
                color: violet,
                textColor: Color.fromRGBO(255, 255, 255, 1),
                child: Text("Modification", style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              width: 150,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Suppression",
                    desc: "Etes vous sur de vouloir supprimer ?",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "oui",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => delete(),
                        width: 120,
                      )
                    ],
                  ).show();

                  /* setState(() {
                          chargement = true;
                        });
                        _register(); */
                },
                padding: EdgeInsets.all(10.0),
                color: violet,
                textColor: Color.fromRGBO(255, 255, 255, 1),
                child: Text("Suppression", style: TextStyle(fontSize: 15)),
              ),
            )
          ],
        ))
      ],
    ));
  }
}
