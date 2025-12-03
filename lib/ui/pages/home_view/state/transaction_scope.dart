import 'package:flutter/material.dart';
import 'package:hello_world/ui/pages/home_view/state/transaction_state.dart';

class TransactionScope extends InheritedWidget {

  final TransactionState state;
  const TransactionScope({super.key, required this.state, required super.child});

  static TransactionScope of(BuildContext context){
    final scope = context.getInheritedWidgetOfExactType<TransactionScope>();
    assert(scope != null, "No TransactionScope found");
    return scope!;
  }
  
  @override
  bool updateShouldNotify(covariant TransactionScope old) => old.state != state;
  
}