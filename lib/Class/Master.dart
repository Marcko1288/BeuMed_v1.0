import 'package:flutter/material.dart';

import '../View/Det_User.dart';
import '../View/HomeView.dart';
import '../View/LoginView.dart';
import '../View/NavLink.dart';
import '../View/ResetPasswordView.dart';
import 'Model/Enum_SelectionView.dart';
import 'Model/Enum_TypeState.dart';
import 'User.dart';

class Master with ChangeNotifier {
  final messageVideo = GlobalKey<ScaffoldMessengerState>();

  late SelectionView selectionView;
  late Users user;
  late List<Users> array_user;

  Master.standard()
      : this.array_user = [],
        this.selectionView = SelectionView.Login;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments as RouteElement;

    switch (settings.name){
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginView());
      case '/resetpassword':
        return MaterialPageRoute(builder: (context) => ResetPasswordView());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeView());
    case '/user_add':
      var element = args.element is Users
          ? args.element as Users
          : null;
      return MaterialPageRoute(builder: (context) =>
          Det_UserView(state: TypeState.insert, user: element));


      // case '/register':
      //   return MaterialPageRoute(builder: (context) => RegisterView());
      // case '/new_password':
      //   return MaterialPageRoute(builder: (context) => ResetView());
      // case '/cash':
      //   return MaterialPageRoute(builder: (context) => CashView());
      // case '/cash_storico':
      //   return MaterialPageRoute( builder: (context) => Stor_CashView(type: args.element as SelectionCashStor,));
      // case '/cash_dettaglio':
      //   return MaterialPageRoute( builder: (context) => Det_CashView(cash: args.element as Cash));
      // case '/cash_add':
      //   var element = args.element is Cash ? args.element as Cash : null;
      //   return MaterialPageRoute( builder: (context) => Det_CashView(state: TypeState.insert, cash: element));
      // case '/contract':
      //   return MaterialPageRoute(builder: (context) => ContractView());
      // case '/contract_storico':
      //   return MaterialPageRoute( builder: (context) => Stor_ContractView(type: args.element as SelectionContractStor,));
      // case '/contract_dettaglio':
      //   return MaterialPageRoute( builder: (context) => Det_ContractView(contract: args.element as Contract));
      // case '/contract_add':
      //   var element = args.element is Contract ? args.element as Contract : null;
      //   return MaterialPageRoute( builder: (context) => Det_ContractView(state: TypeState.insert, contract: element));
      // case '/subcontract':
      //   return MaterialPageRoute(builder: (context) => SubContractView());
      // case '/subcontract_storico':
      //   return MaterialPageRoute( builder: (context) => Stor_SubContractView(type: args.element as SelectionSubContractStor,));
      // case '/subcontract_dettaglio':
      //   return MaterialPageRoute( builder: (context) => Det_SubContractView(subcontract: args.element as SubContract));
      // case '/subcontract_add':
      //   var element = args.element is SubContract ? args.element as SubContract : null;
      //   return MaterialPageRoute( builder: (context) => Det_SubContractView(state: TypeState.insert, subcontract: element));
      //
      // case '/user_add':
      //   var element = args.element is User
      //       ? args.element as User
      //       : null;
      //   return MaterialPageRoute(builder: (context) =>
      //       Det_UserView(state: TypeState.insert, user: element));


      default:
        return MaterialPageRoute( builder: (context) => NavLink());
    }
  }

  void gestion_Message(String message){
    var snackBar = SnackBar(content: Text(message));
    this.messageVideo.currentState?.showSnackBar(snackBar);
  }

  void logOut(){
    this.selectionView = SelectionView.Login;
  }

}

class RouteElement {
  final String title;
  late dynamic element;

  RouteElement(this.title, this.element);
}