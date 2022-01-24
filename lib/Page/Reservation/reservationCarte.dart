import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:opassage_app/api/lienglobal.dart';
import 'package:opassage_app/main.dart';
import 'package:opassage_app/utilities/color.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationDepuisCarte extends StatefulWidget {
  final String name;
  final String matricule;
  final String montant;
  final String description;
  final String localisation;
  ReservationDepuisCarte(
      {Key? key,
      required this.matricule,
      required this.name,
      required this.montant,
      required this.description,
      required this.localisation})
      : super(key: key);

  @override
  _ReservationDepuisCarteState createState() => _ReservationDepuisCarteState();
}

class _ReservationDepuisCarteState extends State<ReservationDepuisCarte> {
  int currentStep = 0;
  int _activeStepIndex = 0;

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatterd = DateFormat('yyyy-MM-dd');
  final DateFormat heureformat = DateFormat('hh:mm');

  String? _selectedTime;
  String? _selectedTime2;
  var datechoisi;
  var heurearrive;
  var heuredepart;

  var name;
  var id;
  var role;
  var email;
  var _telephonecontroller = TextEditingController();
  var h;
  var s;
  var cout;

  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.hour.toString() + ':' + result.minute.toString();
        h = int.parse(result.hour.toString());

        cout = int.parse(widget.montant) * (h - s);
        print(cout);
      });
    }
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
            // remplir();
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
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
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
                        datechoisi = formatter.format(focusedDay);
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
                                      icon: Icon(Icons.alarm),
                                      onPressed: _show),
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
          isActive: _activeStepIndex >= 1,
          title: Text(''),
          content: Text('fff'),
        ) */

        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _activeStepIndex >= 1,
            title: Text(''),
            content: Center(
              child: Column(
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
                                        widget.name,
                                        style: TextStyle(
                                            fontSize: 15,
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
                                        widget.localisation,
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [Text(widget.montant + 'XOF')],
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: TextField(
                                    controller: _telephonecontroller,
                                    enabled: false,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      labelText: '${name}',
                                      hintText: 'Djidjonou Alexis',
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
                                      labelText: 'numero',
                                      hintText: 'Djidjonou Alexis',
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                /*  Padding(
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
                                      labelText: 'IMEI',
                                      hintText: 'IMEI',
                                    ),
                                  ),
                                ), */
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
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                                'Reservation  Hotel Ivoire chambre à l\'heure'),
                          ),
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
                                      Row(
                                        children: [
                                          s == null
                                              ? Container()
                                              : Text('${(h - s)}'),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text('${widget.montant}'),
                                        ],
                                      )
                                      //  Text('${widget.montant} * ${(h - s)}'),
                                      // Text('Frais 0.00')
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: cout != null
                                        ? Text(
                                            cout.toString() + ' ' 'XOF',
                                          )
                                        : Container()),
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
                                child: cout != null
                                    ? Text(
                                        cout.toString() + ' ' 'XOF',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: violet),
                                      )
                                    : Container(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ];

  Future<void> _showq() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime2 =
            result.hour.toString() + ':' + result.minute.toString();
        s = int.parse(result.hour.toString());

        //cout = widget.montant * (h - s);
      });
    }
  }

  Reservation() async {
    var dio = Dio();
    var w = h - s;
    var data = [
      {
        'matricule_espace': widget.matricule,
        'date_reservation': datechoisi,
        'heure_debut': _selectedTime2,
        'heure_fin': _selectedTime,
        'montant': cout,
        'statu': 0,
        'id_user_imei': "1",
        'phone_anonym': _telephonecontroller.text,
      }
    ];

    try {
      final response = await dio.post('${lien}/save_reservation', data: data);
      p();
      //  if (response.data['statu'] == 1) {}
    } catch (e) {
      print(e);
      /*  showModalBottomSheet<void>(
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
          }) */
      ;
    }

    print(data);
  }

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
}
