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
    final theme = Theme.of(context);
    return TextField(
      controller: widget.controller,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        fillColor: theme.inputDecorationTheme.fillColor,
        filled: true,
        labelText: widget.label,
        labelStyle: theme.inputDecorationTheme.labelStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: theme.dividerColor)
        ),
        suffixText: "VND"
      ),
      style: theme.textTheme.bodyMedium
    );
  }

}