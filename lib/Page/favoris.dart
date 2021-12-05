import 'package:flutter/material.dart';

class Favoris extends StatelessWidget {
  const Favoris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          ('Mes hotels favoris'),
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Icon(Icons.favorite),
              ),
              Text(
                'Aucun Favoris',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              Text(
                'Trouver dès maintenant le lieu qui vous correspond',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side:
                          BorderSide(color: Color.fromRGBO(189, 195, 199, 1))),
                  onPressed: () {},
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  textColor: Color.fromRGBO(46, 49, 49, 1),
                  child: Text("Lancer une recherche",
                      style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
