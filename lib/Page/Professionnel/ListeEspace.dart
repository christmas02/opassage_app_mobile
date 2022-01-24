import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opassage_app/Page/Professionnel/detail/detailEspace.dart';
import 'package:opassage_app/Page/profil.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/utilities/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListEspace extends StatefulWidget {
  ListEspace({Key? key}) : super(key: key);

  @override
  _ListEspaceState createState() => _ListEspaceState();
}

class _ListEspaceState extends State<ListEspace> {
  var dio = Dio();
  var name;
  var id;
  var role;

  var listChmabreHeure = [];
  ListChambreHeure() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      id = localStorage.getInt('id');
      role = localStorage.getInt('role');
    });
    var data = {
      'id': id,
    };
    final response =
        await dio.post('${lien}/liste_espace_professionnel', data: data);

    setState(() {
      listChmabreHeure = response.data['data'];
    });
    print('--------------id');
    print(response.data['data']);
  }

//Liste categorie
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
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Profil())),
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
                tabs: List<Widget>.generate(_listCategorie.length, (int index) {
                  return new Tab(text: _listCategorie[index]);
                })),
            backgroundColor: Colors.transparent,
            title: Text(
              'Liste des espaces',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: new TabBarView(
            children: List<Widget>.generate(_listCategorie.length, (int index) {
              _listCategorie[index];
              var t = listChmabreHeure.where((oldValue) =>
                  _listCategorie[index].toString() ==
                  (oldValue['categorie'].toString()));
              // print(_listCategorie[0]);

              return t.length > 0
                  ? ListView(
                      children: t.map((entry) {
                      print('jdkbkdd');
                      print(entry);
                      var w = Container(
                        width: 450,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      10.0) //                 <--- border radius here
                                  ),
                            ),
                            child: GestureDetector(
                              child: ListTile(
                                leading: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/chambre.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                                title: Text(entry['designation'].toString()),
                                subtitle:
                                    Text(entry['localisation'].toString()),
                                trailing: Wrap(
                                  spacing: 12, // space between two icons
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        print('edit');
                                      },
                                      child: Icon(Icons.edit),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailEspace(
                                                        latitude: entry[
                                                            'latitude'],
                                                        longitude: entry[
                                                            'longitude'],
                                                        image_one:
                                                            entry['img_one'],
                                                        image_two:
                                                            entry['img_two'],
                                                        image_thee:
                                                            entry['img_thee'],
                                                        image_for: entry['for'],
                                                        image_five:
                                                            entry['five'],
                                                        disponibilite: entry[
                                                            'disponibilite'],
                                                        commune:
                                                            entry['commune'],
                                                        id: entry['id'],
                                                        description:
                                                            entry['description']
                                                                .toString(),
                                                        montant: entry['montant']
                                                            .toString(),
                                                        name:
                                                            entry['designation']
                                                                .toString(),
                                                        localisation: entry[
                                                                'localisation']
                                                            .toString(),
                                                        matricule:
                                                            entry['matricule']
                                                                .toString(),
                                                        categorie:
                                                            entry['categorie']
                                                                .toString())));
                                      },
                                      child: Icon(Icons.remove_red_eye_sharp),
                                    ), // icon-2
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                      return w;
                    }).toList())
                  : Container(
                      child: Center(
                        child: Text('aucune donnée pour cette categorie'),
                      ),
                    );
            }),
          ),
        ));
  }
}
