import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Professionnel/detail/detailListeReservation.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListeReservationPro extends StatefulWidget {
  ListeReservationPro({Key? key}) : super(key: key);

  @override
  _ListeReservationProState createState() => _ListeReservationProState();
}

class _ListeReservationProState extends State<ListeReservationPro> {
  var dio = Dio();
  List<String> _listCategorie = [];
  loadCategorie() async {
    var response = await dio.get(
      '${lien}/liste_categorie',
    );
    var test = response.data['data'];
    for (var i = 0; i < response.data['data'].length; i++) {
      setState(() {
        _listCategorie.add(response.data['data'][i]['libelle']);
      });
    }
    print('---------------------');
    print(_listCategorie.length);
    /* setState(() {
      _listCategorie = test;
    }); */
  }

  var listChmabreHeure = [];
  ListChambreHeure() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = localStorage.getInt('id');
    var data = {
      'id': id,
    };

    final response =
        await dio.post('${lien}/liste_reservation_professionnel', data: data);

    setState(() {
      listChmabreHeure = response.data['data'];
    });
    print(id);
  }

  @override
  void initState() {
    super.initState();
    ListChambreHeure();
    loadCategorie();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _listCategorie.length,
        child: Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              elevation: 0,
              bottom: TabBar(
                  isScrollable: true,
                  indicatorWeight: 4.0,
                  indicatorColor: Color(0xff990099),
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Creates border
                      color: violet),
                  tabs:
                      List<Widget>.generate(_listCategorie.length, (int index) {
                    return new Tab(text: _listCategorie[index]);
                  })),
              backgroundColor: Colors.transparent,
              title: Text(
                'Liste des Reservations',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: new TabBarView(
              children:
                  List<Widget>.generate(_listCategorie.length, (int index) {
                _listCategorie[index];
                var t = listChmabreHeure.where((oldValue) =>
                    _listCategorie[index].toString() ==
                    (oldValue['libelle'].toString()));
                //print(_listCategorie[0]);
                var attente = listChmabreHeure.where((oldValue) =>
                    _listCategorie[index].toString() ==
                        (oldValue['libelle'].toString()) &&
                    oldValue['statu'] == 0);
                var valider = listChmabreHeure.where((oldValue) =>
                    _listCategorie[index].toString() ==
                        (oldValue['libelle'].toString()) &&
                    oldValue['statu'] == 1);
                print('yhdjdjd-----------');
                print(attente);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        'En attente',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: attente.length > 0
                            ? ListView(
                                children: attente.map((entry) {
                                var w = Container(
                                  width: 450,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                10.0) //                 <--- border radius here
                                            ),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: ListTile(
                                              leading: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/chambre.jpg"),
                                                        fit: BoxFit.cover)),
                                              ),
                                              title: Text(entry['designation']),
                                              subtitle:
                                                  Text(entry['localisation']),
                                              trailing: Wrap(
                                                spacing:
                                                    12, // space between two icons
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailListeReservation(
                                                                    description:
                                                                        entry['description']
                                                                            .toString(),
                                                                    montant: entry[
                                                                            'montant']
                                                                        .toString(),
                                                                    name: entry[
                                                                            'designation']
                                                                        .toString(),
                                                                    localisation:
                                                                        entry['localisation']
                                                                            .toString(),
                                                                    matricule: entry[
                                                                            'matricule']
                                                                        .toString(),
                                                                  )));
                                                    },
                                                    child: Icon(Icons
                                                        .remove_red_eye_sharp),
                                                  ), // icon-2
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                return w;
                              }).toList())
                            : Container(
                                child: Center(
                                  child: Text(
                                      'aucune donnée pour cette categorie'),
                                ),
                              )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        'Valider',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: valider.length > 0
                            ? ListView(
                                children: valider.map((entry) {
                                var w = Container(
                                  width: 450,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                10.0) //                 <--- border radius here
                                            ),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: ListTile(
                                              leading: Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/chambre.jpg"),
                                                        fit: BoxFit.cover)),
                                              ),
                                              title: Text(entry['designation']),
                                              subtitle:
                                                  Text(entry['localisation']),
                                              trailing: Wrap(
                                                spacing:
                                                    12, // space between two icons
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailListeReservation(
                                                                    description:
                                                                        entry[
                                                                            'description'],
                                                                    montant: entry[
                                                                        ' montant'],
                                                                    name: entry[
                                                                        'name'],
                                                                    localisation:
                                                                        entry[
                                                                            'localisation'],
                                                                    matricule:
                                                                        entry[
                                                                            'matricule'],
                                                                  )));
                                                    },
                                                    child: Icon(Icons
                                                        .remove_red_eye_sharp),
                                                  ), // icon-2
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                return w;
                              }).toList())
                            : Container(
                                child: Center(
                                  child: Text(
                                      'aucune donnée pour cette categorie'),
                                ),
                              ))
                  ],
                );
              }),
            )));
  }
}
