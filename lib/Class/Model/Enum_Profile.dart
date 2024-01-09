import 'package:flutter/material.dart';

enum SelectionProfile {
  admin,
  doc,
  paziente,
  segretaria,
}

extension ExtSelectionProfile on SelectionProfile {
  String get value {
    switch (this) {
      case SelectionProfile.admin:
        return 'ADMIN';

      case SelectionProfile.doc:
        return 'DOT';

      case SelectionProfile.paziente:
        return 'PAZ';

      case SelectionProfile.segretaria:
        return 'SEGR';

      default:
        return '';
    }
  }

  static SelectionProfile code (String string) {
    switch (string) {
      case 'ADMIN':
        return SelectionProfile.admin;

      case 'DOT':
        return SelectionProfile.doc;

      case 'PAZ':
        return SelectionProfile.paziente;

      case 'SEGR':
        return SelectionProfile.segretaria;

      default:
        return SelectionProfile.paziente;
    }
  }
}

