import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:beumed/Class/Model/Enum_SelectionView.dart';
import 'package:beumed/View/HomeView.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../Class/Master.dart';
import '../Class/User.dart';
import '../Library/FireAuth.dart';
import 'LoginView.dart';
import 'NavLink.dart';

class GestureView extends StatefulWidget {
  const GestureView({super.key});

  @override
  State<GestureView> createState() => _GestureViewState();
}

class _GestureViewState extends State<GestureView> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);

    return MaterialApp(
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('it', 'IT'),
      ],
      scaffoldMessengerKey: context.watch<Master>().messageVideo,
      title: context.watch<Master>().selectionView.value,
      theme: ThemeData(
      ),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot){
          if (!snapshot.hasData){
            return LoginView();
          } else {
            return FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return HomeView();
                  } else if (snapshot.hasError){
                    return TextButton(onPressed: logOut, child: Text('Dati non scaricati!')) ;
                  }
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
            );
          }
        },
      ),
      onGenerateRoute: Master.generateRoute, // Master.generateRoute,
    );
  }

  Future<bool> getData() async {
    var master = Provider.of<Master>(context, listen: false);

    try {
      print('Estrazione');

      //Estrai User
      // var dirDB_user = FireStore().dirDB(document: '${Auth().currentUser!.uid}', value: 'User');
      // var array_user = await FireStore().queryFireStore(patch: dirDB_user);
      // master.array_user.clear();
      // array_user.forEach((element) {
      //   var user = User.fromJson(element);
      //   master.array_user.add(user);
      //   if(user.uid == Auth().currentUser!.uid) master.user = user;
      // });
      // print('master.array_user: ${master.array_user.length}');
      master.user = Users(mail: 'marc.costigliola@gmail.com', nome: 'Marco', cognome: 'Costigliola', cf: 'CSTMRC', piva: '123456789');
      master.array_user = Users.arrayElement();
      print('Estrazione OK');
      master.selectionView = SelectionView.Home;

      return true;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master.gestion_Message('Autentificazione Fallita! Verificare Email/Passord inseriti. \n ${error.toString()}');
      });
      return false;
    }
  }

  Future<void> logOut() async {
    var master = Provider.of<Master>(context, listen: false);

    master.logOut();
    Auth().singOut();
  }
}
