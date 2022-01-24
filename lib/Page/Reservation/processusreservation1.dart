import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/main.dart';
import 'package:opassage_app/model/resultatrecherchemodele.dart';
import 'package:opassage_app/utilities/color.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ProcessusReservationRecherche extends StatefulWidget {
  List<ResultatRecherche> list;
  ProcessusReservationRecherche({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  _ProcessusReservationRechercheState createState() =>
      _ProcessusReservationRechercheState();
}

class _ProcessusReservationRechercheState
    extends State<ProcessusReservationRecherche> {
  int _counter = 0;
  int currentStep = 0;
  int _activeStepIndex = 0;
  var point;

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat heureformat = DateFormat('hh:mm');

  String? _selectedTime;
  String? _selectedTime2;
  var datechoisi;
  var heurearrive;
  var heuredepart;
  var matricule;
  var montant;
  var montantespace;
  var nobleGases = <String, dynamic>{};
  var test = <Map>[];

  var difference;
  var name;
  var email;
  var id;
  var role;
  var totalmontant = 0;
  var _telephonecontroller = new TextEditingController();

  var heuredebut;
  var heurefin;

  Future<void> _showq() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime2 =
            result.hour.toString() + 'H' ':' + result.minute.toString() + 'mn';
        heuredebut = result.hour;
      });
    }
  }

  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime =
            result.hour.toString() + 'H' ':' + result.minute.toString() + 'mn';
        heurefin = result.hour;
        difference = heurefin - heuredebut;
        widget.list.forEach((item) {
          setState(() {
            montant = int.parse(item.montant.toString()) * difference;
          });
        });
      });
    }
  }

  //alert confirmation
  p() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Réservation effectuée!",
        onConfirmBtnTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        });
  }

  remplir() {
    widget.list.forEach((item) {
      //getting the key direectly from the name of the key
      setState(() {
        nobleGases = {
          'matricule_espace': item.matricule,
          'date_reservation': datechoisi,
          'heure_debut': _selectedTime2,
          'heure_fin': _selectedTime,
          'montant': item.montant,
          'statu': 0,
          'id_user_imei': "1",
          'phone_anonym': _telephonecontroller.text.trim()
        };
        test.add(nobleGases);
      });
    });
  }

  //code reservation
  Reservation() async {
    var dio = Dio();

    var data = test;

    try {
      final response = await dio.post('${lien}/save_reservation', data: data);
      p();
      //  if (response.data['statu'] == 1) {}
    } catch (e) {
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
                      'reservation echoué',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    print('uh');
    print(data);
  }

  data() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      name = localStorage.getString('name');
      email = localStorage.getString('email');
      id = localStorage.getInt('id');
      role = localStorage.getInt('role');
    });
  }

  sum() {
    widget.list.forEach((item) {
      //getting the key direectly from the name of the key
      setState(() {
        totalmontant += int.parse(item.montant.toString());
      });
    });
  }

  void initState() {
    super.initState();
    _show();
    _showq();
    data();
    sum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Réservation',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stepper(
        currentStep: currentStep,
        type: StepperType.horizontal,
        steps: getSteps(),
        onStepTapped: (step) => setState(() => currentStep = step),
        onStepContinue: () {
          final isLaStep = currentStep == getSteps().length - 1;
          if (isLaStep) {
            remplir();
            Reservation();
            print('completed');
          } else {
            setState(() => currentStep += 1);
          }
          ;
        },
        onStepCancel: () {
          currentStep == 0 ? null : setState(() => currentStep -= 1);
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            isActive: _activeStepIndex >= 0,
            title: Text(''),
            content: Center(
              child: Column(
                children: [
                  TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(1940),
                    lastDay: DateTime(2050),
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    daysOfWeekVisible: false,
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                        datechoisi = formatter.format(selectedDay);
                      });
                    },
                    calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                        selectedTextStyle: TextStyle(color: Colors.white)),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  datechoisi != null
                      ? Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date choisie',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                datechoisi,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Heure d\'arrivée',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 0, right: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  margin: EdgeInsets.all(10),
                                  child: IconButton(
                                    icon: Icon(Icons.alarm),
                                    onPressed: _showq,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: _selectedTime2 != null
                                    ? Text(
                                        _selectedTime2 != null
                                            ? _selectedTime2!
                                            : 'No time selected!',
                                      )
                                    : Container(),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Heure de départ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 0, right: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  margin: EdgeInsets.all(10),
                                  child: IconButton(
                                      icon: Icon(Icons.alarm), onPressed: _show

                                      /*  setState(() {
                                        heuredepart = time2;
                                      }); */

                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: _selectedTime != null
                                    ? Text(
                                        _selectedTime != null
                                            ? _selectedTime!
                                            : 'No time selected!',
                                      )
                                    : Container(),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
        /* Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('Complete'),
            content: Container()) */
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text(widget.list.length.toString()),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Resumé de la réservation',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.list.length,
                  itemBuilder: (BuildContext ctxt, i) {
                    final a = widget.list[i];
                    montantespace = a.montant;

                    return new Container(
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
                                    image:
                                        AssetImage("assets/images/chambre.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          a.designation.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
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
                                          a.localisation.toString(),
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 15),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(a.montant.toString()),
                                        // Text(difference.toString())
                                      ],
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                )),
                name != null
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Text(
                                'Information Personnel',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: TextField(
                                  enabled: false,
                                  enableInteractiveSelection: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    labelText: '${name}',
                                    hintText: '',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    labelText: 'Numero de telephone',
                                    hintText: 'Numero de telephone',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 20),
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    labelText: '${email}',
                                    hintText: 'Djidjonou Alexis',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          width: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: [
                              Text(
                                'Information Personnel',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              /*   Padding(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    labelText: 'IMEI',
                                    hintText: 'IMEI',
                                  ),
                                ),
                              ) */
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                child: TextField(
                                  controller: _telephonecontroller,
                                  enabled: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    labelText: 'Numero de telephone',
                                    hintText: 'Numero de telephone',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    width: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      children: [
                        Text(
                          'Detail Reservation',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        /* Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                              'Reservation  Hotel Ivoire chambre à l\'heure'),
                        ) */
                        Text(datechoisi == null ? '' : datechoisi),
                        Text(_selectedTime2 == null
                            ? ''
                            : _selectedTime2.toString() +
                                ' - ' +
                                _selectedTime.toString()),
                        /*   datechoisi != null
                              ? Text(datechoisi +
                                  ' ' +
                                  ' ' +
                                  _selectedTime2 +
                                  ' - ' +
                                  _selectedTime)
                              : Container() */
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20, left: 20),
                                child: Column(
                                  children: [
                                    Text('${montantespace} * ${difference}'),
                                    Text('Frais 0.00')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text('${montant}' + ' XOF'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 300,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, bottom: 15),
                              child: Column(
                                children: [
                                  Text(
                                    'Total.',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: violet),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                '${montant}' + ' XOF',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: violet),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))
      ];
}
