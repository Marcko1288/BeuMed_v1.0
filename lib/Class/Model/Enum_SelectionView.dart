import 'package:flutter/material.dart';

///Le tipologie di valore che può assumere:
///
/// Login       --> View Login: Gestione login dell'app web

enum SelectionView {
  Login,
  ResetPassword,
  Home,
  User_Add,
}

extension ExtSelectionView on SelectionView {
  String get value {
    switch (this) {
      case SelectionView.Login:
        return 'BeuMed ®️';

      case SelectionView.ResetPassword:
        return 'Reset Password';

      case SelectionView.Home:
        return 'BeuMed ®️';

      case SelectionView.User_Add:
        return 'Nuovo Paziente';

      default:
        return '';
    }
  }

  String get route {
    switch (this) {
      case SelectionView.Login:
        return '/login';

      case SelectionView.ResetPassword:
        return '/resetpassword';

      case SelectionView.Home:
        return '/home';

      case SelectionView.User_Add:
        return '/user_add';

      default:
        return '';
    }
  }
}
