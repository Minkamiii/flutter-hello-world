import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';

class RegisterField extends StatefulWidget {

  final RegisterType type;
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const RegisterField({
    super.key, 
    required this.type,
    required this.label,
    required this.icon,
    required this.controller,
  });

  @override
  State<RegisterField> createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.type == RegisterType.email ? TextInputType.emailAddress : TextInputType.text,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.type == RegisterType.password ? 
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
      obscureText: widget.type == RegisterType.password ? !showPassword : false,
    );
  }

}