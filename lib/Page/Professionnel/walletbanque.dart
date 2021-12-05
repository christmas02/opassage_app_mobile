import 'package:flutter/material.dart';
import 'package:opassage_app/utilities/color.dart';

class WalletBanque extends StatefulWidget {
  WalletBanque({Key? key}) : super(key: key);

  @override
  _WalletBanqueState createState() => _WalletBanqueState();
}

class _WalletBanqueState extends State<WalletBanque> {
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
          ('Wallet - Banque'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: 500,
              height: 100,
              decoration: BoxDecoration(
                color: violet,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 10),
                    child: Text(
                      'COMPTE COURANT',
                      style: TextStyle(color: blanc),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      color: blanc,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 10, left: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Column(
                            children: [
                              Text('RE0009898Q'),
                              Text('IDENT - 0098')
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          VerticalDivider(
                            width: 1,
                            color: Colors.black,
                          ),
                          Text(
                            '+ 30.000 XOF',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Column(
                            children: [
                              Text('RE0009898Q'),
                              Text('IDENT - 0098')
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          VerticalDivider(
                            width: 1,
                            color: Colors.black,
                          ),
                          Text(
                            '+ 30.000 XOF',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Column(
                            children: [
                              Text('RE0009898Q'),
                              Text('IDENT - 0098')
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          VerticalDivider(
                            width: 1,
                            color: Colors.black,
                          ),
                          Text(
                            '- 30.000 XOF',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
