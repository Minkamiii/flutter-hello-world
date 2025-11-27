import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';

class LoginField extends StatefulWidget {

  final LoginType type;
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const LoginField({
    super.key, 
    required this.type,
    required this.label,
    required this.icon,
    required this.controller
  });

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        fillColor: theme.inputDecorationTheme.fillColor,
        filled: true,
        labelText: widget.label,
        labelStyle: theme.inputDecorationTheme.labelStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: theme.dividerColor)
        ),
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.type == LoginType.password ? 
                            IconButton(
                              icon: showPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              }
                            ) :
                            null,
      ),
      style: theme.textTheme.bodyMedium,
      obscureText: widget.type == LoginType.password ? !showPassword : false,
    );
  }

}