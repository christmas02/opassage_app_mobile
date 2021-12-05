import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Reservation/processusreservation1.dart';
import 'package:opassage_app/Page/recherche/detailrecherche.dart';
import 'package:opassage_app/model/resultatrecherchemodele.dart';
import 'package:opassage_app/utilities/color.dart';

class ListeRecherche extends StatefulWidget {
  final list;
  ListeRecherche({Key? key, required this.list}) : super(key: key);

  @override
  _ListeRechercheState createState() => _ListeRechercheState();
}

class _ListeRechercheState extends State<ListeRecherche> {
  List<ResultatRecherche> reservationmodel = <ResultatRecherche>[];
  List<ResultatRecherche> _cartList = <ResultatRecherche>[];
  void _populateDishes() {
    reservationmodel.clear();
    setState(() {
      reservationmodel = widget.list;
    });
  }

  @override
  void initState() {
    super.initState();
    _populateDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Resultat de la recherche',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_bag,
                      color: violet,
                      size: 36.0,
                    ),
                    if (_cartList.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.blue,
                          child: Text(
                            _cartList.length.toString(),
                            style: TextStyle(
                              color: blanc,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (_cartList.isNotEmpty)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProcessusReservationRecherche(
                                  list: _cartList,
                                )));
                  else
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
                                    'Veuillez faire vos trois choix',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                },
              ),
            )
          ],
        ),
        body: Container(
            child: reservationmodel.length > 0
                ? ListView.builder(
                    itemCount: reservationmodel.length,
                    itemBuilder: (BuildContext context, int index) {
                      final a = reservationmodel[index];
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        width: double.maxFinite,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailRecherche(
                                          description: a.description.toString(),
                                          montant: a.montant.toString(),
                                          name: a.designation.toString(),
                                          localisation:
                                              a.localisation.toString(),
                                          matricule: a.matricule.toString(),
                                        )));
                          },
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    child: Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.grey)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 150.0,
                                        height: 180.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/chambre.jpg"),
                                                fit: BoxFit.cover)),
                                      ),
                                      GestureDetector(
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        a.designation
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Text(
                                                        a.localisation
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15),
                                                  ),
                                                  Text(
                                                    a.montant.toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: violet,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.date_range,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(a.disponibilite
                                                            .toString())
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 5,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.alarm,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(a.disponibilite
                                                            .toString())
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0,
                                                                bottom: 8.0,
                                                                top: 10),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child:
                                                              GestureDetector(
                                                            child: (!_cartList
                                                                    .contains(
                                                                        a))
                                                                ? Icon(
                                                                    Icons
                                                                        .add_circle,
                                                                    color: Colors
                                                                        .green,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                            onTap: () {
                                                              setState(() {
                                                                if (!_cartList
                                                                        .contains(
                                                                            a) &&
                                                                    _cartList
                                                                            .length <
                                                                        3)
                                                                  _cartList
                                                                      .add(a);
                                                                else
                                                                  _cartList
                                                                      .remove(
                                                                          a);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                      /*  Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              width: 1000,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProcessusReservation1()));
                },
                padding: EdgeInsets.all(10.0),
                color: violet,
                textColor: Color.fromRGBO(255, 255, 255, 1),
                child: Text("Reserver", style: TextStyle(fontSize: 15)),
              ),
            ) */
                    },
                  )
                : Center(
                    child:
                        Text('Aucun resultat disponible pour cette recherche'),
                  )));
  }
}
