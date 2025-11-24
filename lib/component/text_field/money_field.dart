import 'package:flutter/material.dart';

class MoneyField extends StatefulWidget {

  final String label;
  final TextEditingController controller;

  const MoneyField({
    super.key, 
    required this.label,
    required this.controller
  });

  @override
  State<MoneyField> createState() => _MoneyFieldState();
}

class _MoneyFieldState extends State<MoneyField> {

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        suffixText: "VND"
      ),
    );
  }

}