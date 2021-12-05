import 'package:flutter/material.dart';
import 'package:opassage_app/Page/scan.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';

class Reservation extends StatefulWidget {
  Reservation({Key? key}) : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  List _list = [];
  var test1;
  loadAssignationdata() async {
    var response = await dio.get(
      'http://opassage.impactafric.com/api/liste_espace_default',
    );

    var test = response.data['data'];
    print('----------------bah je comprend pas --------------');
    setState(() {
      _list = test;
    });
    print(_list);
  }

  @override
  void initState() {
    super.initState();
    loadAssignationdata();
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
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text('Liste des reservations',
              style: TextStyle(color: Colors.black)),
        ),
        body: Container(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: double.maxFinite,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Scan()));
                },
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/chambre.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Les plumes Hotels',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 15,
                                          ),
                                          Text(
                                            'Cocody Blockhauss',
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                      ),
                                      Text(
                                        '30000 XOF',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: violet,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
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
                                          top: 5,
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
