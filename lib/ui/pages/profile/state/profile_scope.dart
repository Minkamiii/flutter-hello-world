import 'package:flutter/material.dart';
import 'package:hello_world/ui/pages/profile/state/profile_state.dart';

class ProfileScope extends InheritedWidget {

  final ProfileState state;
  const ProfileScope({super.key, required this.state, required super.child});

  static ProfileScope of(BuildContext context){
    final scope = context.getInheritedWidgetOfExactType<ProfileScope>();
    assert(scope!=null, "No ProfileScope found");
    return scope!;
  }
  
  @override
  bool updateShouldNotify(covariant ProfileScope old) => old.state != state; 
  
}