import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/l10n/app_localizations.dart';

extension TransactionTypeLocalization on TransactionType {
  String localized(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    switch (this) {
      case TransactionType.gain:
        return loc.gain;
      case TransactionType.withdraw:
        return loc.withdraw;
    }
  }
}