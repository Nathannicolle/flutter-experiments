// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'Timer.g.dart';


Timer timerFromJson(String str) => Timer.fromJson(json.decode(str));

String timerToJson(Timer data) => json.encode(data.toJson());

class Timer {
  Timer({
    required this.name,
    this.description = '',
    this.duee = 0,
    this.statut = false,
    this.visible = true,
    this.ordre = 0,
  }):activationDate=DateTime.now();

  String name;
  String description;
  int duee;
  bool statut;
  bool visible;
  int ordre;
  DateTime? activationDate;

  factory Timer.fromJson(Map<String, dynamic> json) {
    Timer t = Timer(
      name: json["name"]??'',
      description: json["description"]??'',
      duee: json["duee"]??0,
      statut: json["statut"]??false,
      visible: json["visible"]??false,
      ordre: json["ordre"]??0,
    );
    t.activationDate = DateTime.tryParse(json["activationDate"]??'');
    return t;
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "duee": duee,
    "statut": statut,
    "visible": visible,
    "ordre": ordre,
    "activationDate": "${activationDate!.year.toString().padLeft(4, '0')}-${activationDate!.month.toString().padLeft(2, '0')}-${activationDate!.day.toString().padLeft(2, '0')}",
  };
}

@Collection<Timer>('/Timer/')
final timersRef = TimerCollectionReference();