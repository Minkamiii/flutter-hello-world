import 'package:flutter/material.dart';
import 'package:hello_world/ui/pages/add_transaction/state/add_transaction_state.dart';

class AddTransactionScope extends InheritedWidget {

  final AddTransactionState state;
  const AddTransactionScope({super.key, required this.state, required super.child});

  static AddTransactionScope of(BuildContext context){
    final scope = context.dependOnInheritedWidgetOfExactType<AddTransactionScope>();
    assert(scope != null, "No AddTransactionScope found");
    return scope!;
  }

  @override
  bool updateShouldNotify(covariant AddTransactionScope old) => old.state != state;

}