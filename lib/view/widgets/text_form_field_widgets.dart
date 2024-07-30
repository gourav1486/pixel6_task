import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final String label;
  final String hintText;
  final AutovalidateMode? validateMode;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Function(String?)? onChange;
  final String? prefix;
  final Widget? suffixIcon;
  final bool? enabled;
  const TextFormFieldWidget(
      {super.key,
      required TextEditingController controller,
      this.validator,
      required this.hintText,
      this.enabled,
      this.validateMode,
      this.keyboardType,
      this.maxLength,
      this.onChange,
      this.prefix,
      this.suffixIcon,
      required this.label})
      : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        validator: validator,
        enabled: enabled,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
        autovalidateMode: validateMode,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        onChanged: onChange,
        decoration: InputDecoration(
            prefixText: prefix,
            labelText: label,
            suffixIcon: suffixIcon,
            labelStyle: TextStyle(color: Colors.white),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            fillColor: Colors.white.withOpacity(0.2),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2)),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
