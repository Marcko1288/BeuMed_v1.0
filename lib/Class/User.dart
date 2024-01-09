import 'package:flutter/material.dart';
import 'package:beumed/Class/Model/Enum_Profile.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:uuid/uuid.dart';

import '../Library/Enum_TypeExtraction.dart';


class Users {
  //Variabili
  late String   uid;
  late String   mail;
  late String   cf;
  late String   piva;
  late String   nome;
  late String   cognome;
  late SelectionProfile   profilo;
  late DateTime data_ins;
  late DateTime data_modify;
  //Costruttore
  Users({
    String? uid,
    String? cf,
    String? piva,
    SelectionProfile? profilo,
    required this.mail,
    required this.nome,
    required this.cognome,
    DateTime? data_ins,
    DateTime? data_modify
  }) : this.uid = uid ?? Uuid().v4().toUpperCase(),
        this.cf = cf ?? '',
        this.piva = piva ?? '',
        this.profilo = profilo ?? SelectionProfile.paziente,
        this.data_ins = data_ins ?? DateTime.now(),
        this.data_modify = data_modify ?? DateTime.now();


  //Default
  Users.standard({
    this.mail = '',
    this.nome = '',
    this.cognome = '',
  });

  //FROM JSON
  factory Users.fromJson(Map<String, dynamic> json) {
    var data_ins = DateTime.now();
    if(json['data_ins'].runtimeType == 'String') {
      data_ins = json['data_ins'].toString().changeStringToDate();
    }
    var data_modify = json['data_modify']?.toDate() ?? DateTime.now();
    return Users(
      uid: json['uid'].runtimeType == 'String' ? json['uid'].toString() : '',
      mail: json['mail'].runtimeType == 'String' ? json['mail'].toString() : '',
      cf: json['cf'].runtimeType == 'String' ? json['cf'].toString() : '',
      piva: json['piva'].runtimeType == 'String' ? json['piva'].toString() : '',
      nome: json['nome'].runtimeType == 'String' ? json['nome'].toString() : '',
      cognome: json['cognome'].runtimeType == 'String' ? json['cognome'].toString() : '',
      profilo: json['profilo'].runtimeType == 'String' ? SelectionProfile.code(json['profilo'].toString()) : SelectionProfile.paziente,
      data_ins: json['data_ins'].runtimeType == 'String' ? json['data_ins'].toString().changeStringToDate() : DateTime.now(),
      data_modify: json['data_modify'].runtimeType == 'String' ? json['data_modify'].toString().changeStringToDate() : DateTime.now(),
    );
  }

  //TO JSON
  Map<String, dynamic> toDB() => {
    'uid' : uid,
    'mail' : mail,
    'cf' : cf,
    'piva' : piva,
    'nome' : nome,
    'cognome' : cognome,
    'data_ins' : data_ins,
    'data_modify' : data_modify
  };

  //Stampa Testata
  String printFirstLine() {
    return 'UID;Mail;CF;PIVA;Nome;Cognome;Data Inserimento;Data Modifica';
  }

  //Stampa Elementi
  String printLine(){
    return '${this.uid};'
        '${this.mail};'
        '${this.cf};'
        '${this.piva};'
        '${this.nome};'
        '${this.cognome};'
        '${this.data_ins.changeDateToString()};'
        '${this.data_modify.changeDateToString()};';
  }

  //Estrazione Single/Multy JSON
  dynamic extractionDB({required Map<String, dynamic> dictionary, TypeExtraction type = TypeExtraction.multy}) {
    if (dictionary.isEmpty) {
      switch (type) {
        case TypeExtraction.single:
          dynamic dic = dictionary.keys.toList().first;
          return Users.fromJson(dic);
        case TypeExtraction.multy:
          List<Users> array = [];
          for( var dic in dictionary.values) {
            array.add(Users.fromJson(dic));
          }
          return array;
      }
    }
  }

  //Array Esempio
  static List<Users> arrayElement(){
    List<Users> array = [];
    array.add(
        Users(mail: "niko.ortolani1@gmail.com", cf: "Drago5688", nome: "Niko", cognome: "Ortolani")
    );

    array.add(
        Users(mail: "m.andreotti@aciemmeautomobili.it", piva: "Pika86chu", nome: "Michele", cognome: "Andreotti")
    );

    array.add(
        Users(mail: "giorgiaasinaro@gmail.com", cf: "Giorgia", nome: "Giorgia", cognome: "Asinaro")
    );

    array.add(
        Users(mail: "sdasfsafsd@gmail.com", piva: "Pippo", nome: "Pippo", cognome: "Asinaro")
    );

    array.add(
        Users(mail: "asdwqe3e@gmail.com", piva: "Pluto", nome: "Pluto", cognome: "Pluto")
    );
    return array;
  }
}
