import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Class/Model/Enum_TypeState.dart';
import '../Class/User.dart';
import '../Library/FireAuth.dart';
import '../Library/FireStore.dart';
import '../Model/TextFieldCustom.dart';

class Det_UserView extends StatefulWidget {
  Det_UserView({super.key, this.state = TypeState.read, this.user});

  late Users? user;
  late TypeState state;

  @override
  State<Det_UserView> createState() => _Det_UserViewState();
}

class _Det_UserViewState extends State<Det_UserView> {

  late String title;
  late String mail = "";
  late String cf = "";
  late String piva = "";
  late String nome = "";
  late String cognome = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    var size_width = MediaQuery.of(context).size.width * 0.4;
    var size_width_padding = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android
        ? 10.0
        : 100.0;
    var size_text = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android
        ? 18.0
        : 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          if(widget.state != TypeState.insert)
            IconButton(onPressed: deleteElement,
                icon: Icon(Icons.delete_forever_outlined)),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size_width_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: size_width,
                            child: Text(
                              'Mail',
                              style: TextStyle(
                                  fontSize: size_text, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TextFieldCustom(
                            text: mail,
                            modify_text: mail,
                            keyboardType: TextInputType.emailAddress,
                            enabled: widget.state == TypeState.read ? false : true,
                            decoration: TypeDecoration.focusBord,
                            onStringChanged: (String value) {
                              mail = value;
                            },
                            listValidator: [
                              TypeValidator.required,
                              TypeValidator.email
                            ]
                        ),
                      ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: size_width,
                              child: Text(
                                'Nome',
                                style: TextStyle(
                                    fontSize: size_text, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TextFieldCustom(
                              text: nome,
                              modify_text: nome,
                              enabled: widget.state == TypeState.read ? false : true,
                              decoration: TypeDecoration.focusBord,
                              onStringChanged: (String value) {
                                nome = value;
                              },
                              listValidator: []
                          ),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: size_width,
                              child: Text(
                                'Cognome',
                                style: TextStyle(
                                    fontSize: size_text, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TextFieldCustom(
                              text: cognome,
                              modify_text: cognome,
                              enabled: widget.state == TypeState.read ? false : true,
                              decoration: TypeDecoration.focusBord,
                              onStringChanged: (String value) {
                                cognome = value;
                              },
                              listValidator: []
                          ),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: size_width,
                              child: Text(
                                'Codice Fiscale',
                                style: TextStyle(
                                    fontSize: size_text, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TextFieldCustom(
                              text: cf,
                              modify_text: cf,
                              enabled: widget.state == TypeState.read ? false : true,
                              decoration: TypeDecoration.focusBord,
                              onStringChanged: (String value) {
                                cf = value;
                              },
                              listValidator: [
                                //TypeValidator.cf,
                              ]
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
      floatingActionButton: action_button(context),
    );
  }

  Widget action_button(BuildContext contextT){
    return FloatingActionButton(
      onPressed: (){actionElement();}, //() => {},
      tooltip: 'Modifica Elemento',
      child: widget.state == TypeState.read ? Icon(Icons.mode_edit_outline_outlined) : Icon(Icons.save_as_outlined),
    );
  }

  void detTitle(){
    setState(() {
      switch (widget.state){
        case TypeState.read:
          title = "Dettaglio";
        case TypeState.insert:
          title = "Nuovo";
        case TypeState.modify:
          title = "Modifica";
      }
    });
  }

  void refreshDate(){
    setState(() {
      detTitle();
      if(widget.state == TypeState.insert){
        mail = '';
        cf = '';
        nome = '';
        cognome = '';
      } else {
        mail = widget.user!.mail;
        cf = widget.user!.cf;
        nome = widget.user!.nome;
        cognome = widget.user!.cognome;
      }
    });
  }

  Future<void> actionElement() async {
    var master = Provider.of<Master>(context, listen: false);

    if(widget.state != TypeState.read && _formKey.currentState!.validate()){

      if(widget.state == TypeState.insert){
        await insertElement();
      } else if(widget.state == TypeState.modify){
        await modifyElement();
      }
    } else {
      setState(() {
        widget.state = TypeState.modify;
      });
    }
  }

  Future<void> insertElement() async {
    var master = Provider.of<Master>(context, listen: false);

    var result_data = master.array_user.where((e) => e.mail == mail);
    print('${result_data.length}');
    if (result_data.isNotEmpty){
      setState(() {
        master.gestion_Message('Utente già registrato!');
        return ;
      });
    } else {
      var user = Users(
          mail: mail,
          cf: cf,
          nome: nome,
          cognome: cognome
      );

      try {
        var dirDB = FireStore().dirDB(document: '${Auth().currentUser!.uid}', value: 'User');
        var element_map = user.toDB();
        await FireStore().insertFirestore(patch: dirDB, map: element_map);
        print('Caricamento OK');
        widget.user = user;
        master.array_user.add(user);

        setState(() {
          master.gestion_Message('Dati caricati correttamente');
          widget.state = TypeState.read;
          refreshDate();
          return ;
        });
        return ;
      } on FirebaseException catch (error) {
        print('${error.toString()}');
        setState(() {
          master.gestion_Message('Errore caricamento nel DB, ${error.toString()}');
          return ;
        });
        return ;
      }
    }
  }

  Future<void> modifyElement() async{
    var master = Provider.of<Master>(context, listen: false);
    var index = master.array_user.indexWhere((element) => element.uid == widget.user!.uid);
    master.array_user[index].mail = mail;
    master.array_user[index].cf = cf;
    master.array_user[index].nome = nome;
    master.array_user[index].cognome = cognome;

    try {
      var dirDB = FireStore().dirDB(document: '${Auth().currentUser!.uid}', value: 'User');
      var element_map = master.array_user[index].toDB();
      await FireStore().modifyFireStore(patch: dirDB, map: element_map);
      print('Modifica OK');

      setState(() {
        master.gestion_Message('Dati modificati correttamente');
        widget.state = TypeState.read;
        refreshDate();
        return ;
      });
      return ;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master.gestion_Message('Errore caricamento nel DB, ${error.toString()}');
        return ;
      });
      return ;
    }
  }

  Future<void> deleteElement() async{
    var master = Provider.of<Master>(context, listen: false);
    var index = master.array_user.indexWhere((element) => element.uid == widget.user!.uid);

    try {
      var dirDB = FireStore().dirDB(document: '${Auth().currentUser!.uid}', value: 'User');
      var element_map = master.array_user[index].toDB();
      await FireStore().cancelFireStore(patch: dirDB, map: element_map);
      print('Cancellazione OK');

      master.array_user.removeAt(index);

      setState(() {
        master.gestion_Message('Dati cancellati correttamente');
        Navigator.pop(context);
        return ;
      });

      return ;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master.gestion_Message('Errore caricamento nel DB, ${error.toString()}');
        return ;
      });
      return ;
    }
  }

}

