import 'dart:io';

import 'package:device_information/device_information.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:device_info/device_info.dart';
import 'package:opassage_app/Page/detail.dart';
import 'package:opassage_app/Page/recherche/recherche.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/model/espace.dart';
import 'package:opassage_app/model/resultatrecherchemodele.dart';
import 'package:opassage_app/utilities/color.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var favoris = false;

  late GoogleMapController mapController;

  var categorie;
  var commune;
  var cout;
  bool valuefirst = false;
  bool valuesecond = false;
  double zoomVal = 5.0;

  final TextEditingController _prixController = new TextEditingController();
  final TextEditingController _communeController = new TextEditingController();
  final TextEditingController _categorieController =
      new TextEditingController();

  List _list = [];
  List _listcommune = [];
  List _listPrix = [];
  List _listCategorie = [];
  var test1;
  loadAssignationdata() async {
    var response = await dio.get(
      '${lien}/liste_espace_default',
    );

    var test = response.data['data'];
    print('----------------bah je comprend pas --------------');

    setState(() {
      _list = test;
    });
    print('----------------hjdjge --------------');
  }

  loadCommune() async {
    var response = await dio.get(
      '${lien}/liste_commune',
    );
    var test = response.data['data'];
    setState(() {
      _listcommune = test;
    });
  }

  loadPrix() async {
    var response = await dio.get(
      '${lien}/liste_montant',
    );
    var test = response.data['data'];
    setState(() {
      _listPrix = test;
    });
  }

  loadCategorie() async {
    var response = await dio.get(
      '${lien}/liste_categorie',
    );
    var test = response.data['data'];
    setState(() {
      _listCategorie = test;
    });
  }

  List<ResultatRecherche> _listresltat = [];
  resultatdat() async {
    var dio = Dio();
    var data = {
      'montant': cout,
      'commune': commune,
      'categorie': categorie,
    };
    final response = await dio.post('${lien}/filter', data: data);
    var test = response.data['data'];
    print(response.data);
    setState(() {
      for (var i in test) {
        _listresltat.add(ResultatRecherche.fromJson(i));
      }
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListeRecherche(
                  list: _listresltat,
                )));
  }

  var locationMessage = '';
  late String latitude;
  late String longitude;

  var long;
  var lat;

  getPosi() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('----------');
    setState(() {
      long = position.longitude;
      lat = position.altitude;
    });
    print(long);
    print(lat);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

// IMEI

  String _platformVersion = 'Unknown',
      _imeiNo = "",
      _modelName = "",
      _manufacturerName = "",
      _deviceName = "",
      _productName = "",
      _cpuType = "",
      _hardware = "";
  var _apiLevel;

  Future<void> initPlatformState() async {
    late String platformVersion,
        imeiNo = '',
        modelName = '',
        manufacturer = '',
        deviceName = '',
        productName = '',
        cpuType = '',
        hardware = '';
    var apiLevel;
    // Platform messages may fail,
    // so we use a try/catch PlatformException.
    try {
      platformVersion = await DeviceInformation.platformVersion;
      imeiNo = await DeviceInformation.deviceIMEINumber;
      modelName = await DeviceInformation.deviceModel;
      manufacturer = await DeviceInformation.deviceManufacturer;
      apiLevel = await DeviceInformation.apiLevel;
      deviceName = await DeviceInformation.deviceName;
      productName = await DeviceInformation.productName;
      cpuType = await DeviceInformation.cpuName;
      hardware = await DeviceInformation.hardware;
    } on PlatformException catch (e) {
      platformVersion = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "Running on :$platformVersion";
      _imeiNo = imeiNo;
      _modelName = modelName;
      _manufacturerName = manufacturer;
      _apiLevel = apiLevel;
      _deviceName = deviceName;
      _productName = productName;
      _cpuType = cpuType;
      _hardware = hardware;
    });
    print('---------------imei');
    print(_imeiNo);
  }

  List<Marker> makers = [];
  initialize() {
    Marker first = Marker(
        markerId: MarkerId('test1'),
        position: LatLng(5.323690, -4.080420),
        infoWindow: InfoWindow(title: 'test1'),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));
    Marker first2 = Marker(
        markerId: MarkerId('test2'),
        position: LatLng(5.353690, -4.060420),
        infoWindow: InfoWindow(title: 'test1', snippet: 'test1'),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));
    makers.add(first);
    makers.add(first2);
    setState(() {});
  }

  List<Espacemap> Espace = [];
  loadR() async {
    var response = await dio.get(
      '${lien}/liste_espace_default',
    );
    var test = response.data['data'];
    print(test);
    setState(() {
      for (var i in test) {
        Espace.add(Espacemap.fromJson(i));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadR();
    loadAssignationdata();
    loadCommune();
    loadPrix();
    loadCategorie();
  }

  Widget buildSheet() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(MdiIcons.close)),
                Text(
                  'Filtre',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                Text(
                  'Réintialiser',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Text(
            'Autres filtres',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          Row(
            children: [
              Checkbox(
                  value: valuefirst,
                  onChanged: (value) {
                    setState(() {
                      valuefirst = !valuefirst;
                    });
                    Text('Remember me');
                  }),
              Text('Confirmation imédiate')
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: valuefirst,
                  onChanged: (value) {
                    setState(() {
                      valuefirst = !valuefirst;
                    });
                    Text('Remember me');
                  }),
              Text('Accès Piscine')
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 50.0,
            width: 1000,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {},
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(75, 1, 94, 1),
              textColor: Color.fromRGBO(255, 255, 255, 1),
              child: Text("Afficher les résultats",
                  style: TextStyle(fontSize: 15)),
            ),
          )
        ],
      );

  Widget buildPaiement(name, montant, localisation, matricule, description) =>
      Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(MdiIcons.close)),
            ],
          ),
          Text('Processus de paiement'),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(
                          description: description,
                          montant: montant,
                          name: name,
                          localisation: localisation,
                          matricule: matricule,
                        ))),
            child: Text('detail'),
          )
        ],
      );
  Widget buildPaiement2(categorie, commune, cout) => Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(MdiIcons.close)),
            ],
          ),
          Text('Processus de paiement'),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              resultatdat();
            },
            /* ,*/
            child: Text('Poursuivre'),
          )
        ],
      );

  Widget cartepoint(description, localisation, montant, name, matricule) =>
      Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(MdiIcons.close)),
            ],
          ),
          Text('Processus de paiement'),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Details(
                            description: description,
                            localisation: localisation,
                            montant: montant.toString(),
                            name: name,
                            matricule: matricule.toString(),
                          )));
            },
            child: Text('Poursuivre'),
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: /* Container(
                height: 1000,
                width: 1000,
                color: violet,
                child: Text('ok'),
              ) */
                  GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: Espace.map((e) {
                  return Marker(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => cartepoint(
                                e.description,
                                e.localisation,
                                e.montant,
                                e.nameHotel,
                                e.matricule));
                      },
                      markerId: MarkerId('test1'),
                      position: LatLng(double.parse(e.latitude.toString()),
                          double.parse(e.longitude.toString())),
                      infoWindow: InfoWindow(title: e.montant),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet));
                }).toSet(),
                /*  makers.map((e) => e).toSet(), */
                initialCameraPosition: CameraPosition(
                    target: LatLng(5.370210399999999, -3.9386675), zoom: 12),
              ),
            ),
            Positioned(
                child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 60,
              ),
              child: Container(
                  decoration: BoxDecoration(
                    color: blanc,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return new Container(
                                  height: 600.0,

                                  //could change this to Color(0xFF737373),
                                  //so you don't have to change MaterialApp canvasColor
                                  child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(30.0),
                                              topRight:
                                                  const Radius.circular(30.0))),
                                      child: new ListView(
                                        children: [
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(Icons.close)),
                                                Text(
                                                  'Filtre',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 5),
                                                  child: Text(
                                                    'Réinitialiser',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              'Prix',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              margin: EdgeInsets.all(10),
                                              child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'selectionnez',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 20),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                ),
                                                value: cout,
                                                items: _listPrix
                                                    .map((label) =>
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              label['montant']),
                                                          value:
                                                              label['montant'],
                                                        ))
                                                    .toList(),
                                                hint: Text('selectionnez'),
                                                onChanged: (value) {
                                                  setState(() {
                                                    cout = value!;
                                                  });
                                                },
                                              )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              'Commune',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              margin: EdgeInsets.all(10),
                                              child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'selectionnez',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 20),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                ),
                                                value: commune,
                                                items: _listcommune
                                                    .map((label) =>
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              label['libelle']),
                                                          value: label['id'],
                                                        ))
                                                    .toList(),
                                                hint: Text('selectionnez'),
                                                onChanged: (value) {
                                                  setState(() {
                                                    commune = value!;
                                                  });
                                                },
                                              )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(
                                              'Categorie',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, right: 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              margin: EdgeInsets.all(10),
                                              child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  hintText: 'selectionnez',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 20),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                ),
                                                value: categorie,
                                                items: _listCategorie
                                                    .map((label) =>
                                                        DropdownMenuItem(
                                                          child: Text(
                                                              label['libelle']),
                                                          value: label['id'],
                                                        ))
                                                    .toList(),
                                                hint: Text('selectionnez'),
                                                onChanged: (value) {
                                                  setState(() {
                                                    categorie = value!;
                                                  });
                                                },
                                              )),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            height: 50.0,
                                            width: 1000,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              onPressed: () {
                                                // resultatdat()
                                                /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListeRecherche(reservationModel: null,))) */
                                                ;
                                                // ListeRecherche

                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        buildPaiement2(
                                                            categorie,
                                                            cout,
                                                            commune));

                                                /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListeRecherche())) */
                                                ;
                                              },
                                              padding: EdgeInsets.all(10.0),
                                              color:
                                                  Color.fromRGBO(75, 1, 94, 1),
                                              textColor: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              child: Text(
                                                  "Afficher les résultats",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              });
                        },
                        icon: Icon(
                          MdiIcons.filter,
                          color: violet,
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey),
                      hintText: "Recherche....",
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                  )),
            )),
            Positioned(
                top: 400,
                left: 0.0,
                right: 0.0,
                bottom: 00,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, i) {
                    final a = _list[i];
                    return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(
                                        name: a['name_hotel'],
                                        description: a['description'],
                                        montant: a['montant'].toString(),
                                        localisation:
                                            a['localisation'].toString(),
                                        matricule: a['matricule'].toString()))) */

                            showModalBottomSheet(
                                context: context,
                                builder: (context) => buildPaiement(
                                      a['name_hotel'].toString(),
                                      a['montant'].toString(),
                                      a['localisation'].toString(),
                                      a['matricule'].toString(),
                                      a['description'].toString(),
                                    ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: jaune.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 0.5,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                            ),
                            height: 120,
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                children: [
                                  Positioned(
                                      child: Image.asset(
                                          'assets/images/téléchargement.jfif')),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 400,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: blanc,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Stack(
                                            children: [
                                              Text(a['name_hotel'],
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 20)),
                                              Positioned(
                                                  top: 25,
                                                  child: Text(a['localisation'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 11))),
                                              Positioned(
                                                  right: 0,
                                                  bottom: 0,
                                                  child: Text(
                                                      a['montant'] + ' ' 'XOF',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: violet,
                                                          fontSize: 15)))
                                            ],
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    left: 5,
                                    top: 4,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          /*  Icon(
                                            Icons.favorite,
                                            color: violet,
                                            size: 30,
                                          ) */

                                          IconButton(
                                              onPressed: () async {
                                                /* var dio = Dio();
                                                var data = {
                                                  "id_user": "15",
                                                  "id_espace": "33"
                                                };

                                                final response = await dio.post(
                                                    '${lien}/favoris',
                                                    data: data); */

                                                setState(() {
                                                  favoris = !favoris;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: favoris == false
                                                    ? Colors.white
                                                    : violet,
                                                size: 30,
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                            ),
                          ),
                        ));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
