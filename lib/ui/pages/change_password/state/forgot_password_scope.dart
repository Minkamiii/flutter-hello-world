import 'package:flutter/material.dart';
import 'package:hello_world/ui/pages/change_password/state/forgot_password_state.dart';

class ForgotPasswordScope extends InheritedWidget {

  final ForgotPasswordState state;
  const ForgotPasswordScope({super.key, required this.state, required super.child});

  static ForgotPasswordScope of(BuildContext context){
    final scope = context.getInheritedWidgetOfExactType<ForgotPasswordScope>();
    assert(scope != null, "No ForgotPasswordScope found");
    return scope!; 
  }

  @override
  bool updateShouldNotify(covariant ForgotPasswordScope old) => old.state != state;
}