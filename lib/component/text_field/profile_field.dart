import 'package:flutter/material.dart';

class ProfileField extends StatefulWidget {

  final String label;
  final TextEditingController controller;
  final bool isEditable;
  final String? value;

  const ProfileField({
    super.key, 
    required this.label,
    required this.controller,
    this.isEditable = true,
    this.value
  });

  @override
  State<ProfileField> createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      autocorrect: false,
      textCapitalization: TextCapitalization.sentences,
      readOnly: !widget.isEditable,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

}