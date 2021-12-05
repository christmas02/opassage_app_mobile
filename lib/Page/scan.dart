import 'package:flutter/material.dart';
import 'package:opassage_app/utilities/color.dart';

class Scan extends StatefulWidget {
  Scan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Ticket - Reservation ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: violet,
                            ),
                            height: 270,
                            width: 200,
                            child: Column(
                              children: [Text('ok')],
                            ))),
                    Positioned(
                        top: 0,
                        child: Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/téléchargement.jfif',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: null,
                        )),
                    Positioned(
                        bottom: 10,
                        child: Column(
                          children: [
                            Text(
                              'Hotel Ivoire',
                              style: TextStyle(
                                  color: blanc, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                Text(
                                  'Cocody Blockauss',
                                  style: TextStyle(
                                      color: blanc,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 55, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '30000 XOF',
                                      style: TextStyle(
                                          color: blanc,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today),
                                        Text(
                                          'Sam 18 Oct 2021',
                                          style: TextStyle(
                                              color: blanc,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '18H - 21H',
                                          style: TextStyle(
                                              color: blanc,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ))
                  ],
                ),
              ))),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: violet,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/codeqr.jpeg',
                width: 150,
              ),
            ),
          )
        ],
      ),
    );
  }
}
