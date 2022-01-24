import 'package:flutter/material.dart';
import 'package:opassage_app/Page/scan.dart';
import 'package:opassage_app/utilities/color.dart';

class ListeReservation extends StatefulWidget {
  ListeReservation({Key? key}) : super(key: key);

  @override
  _ListeReservationState createState() => _ListeReservationState();
}

class _ListeReservationState extends State<ListeReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Liste des reservations'),
        ),
        body: Container(
            /*  child:
              ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: double.maxFinite,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Scan()));
                  },
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/chambre.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Les plumes Hotels',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 30),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.grey,
                                        ),
                                        Text('18 Octobre 2021')
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: Colors.grey,
                                        ),
                                        Text('10:00 à 12:00')
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                  height: 20,
                  color: jaune,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20)
            ],
          ) */

            ));
  }
}
