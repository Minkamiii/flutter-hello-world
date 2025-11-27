import 'package:flutter/material.dart';

class DescriptionField extends StatefulWidget {

  final String label;
  final TextEditingController controller;
  final bool isEditable;
  final String? value;

  const DescriptionField({
    super.key, 
    required this.label,
    required this.controller,
    this.isEditable = true,
    this.value,
  });

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.value ?? "";
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return TextField(
      controller: widget.controller,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      readOnly: !widget.isEditable,
      decoration: InputDecoration(
        fillColor: theme.inputDecorationTheme.fillColor,
        filled: true,
        labelText: widget.label,
        labelStyle: theme.inputDecorationTheme.labelStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: theme.dividerColor)
        ),
      ),
      style: theme.textTheme.bodyMedium,
    );
  }

}