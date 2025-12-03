import 'package:flutter/material.dart';
import 'package:hello_world/ui/pages/settings/cubit/setting_state.dart';

class SettingScope extends InheritedWidget {
  
  final SettingState state;
  const SettingScope({super.key, required this.state, required super.child});

  static SettingScope of(BuildContext context){
    final scope = context.getInheritedWidgetOfExactType<SettingScope>();
    assert(scope!=null, "No SettingScope found");
    return scope!;
  }
  
  @override
  bool updateShouldNotify(covariant SettingScope old) => old.state != state;
  
}