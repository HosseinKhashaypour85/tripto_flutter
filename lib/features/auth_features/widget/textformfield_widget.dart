import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripto_flutter/const/theme/colors.dart';

class TextFormFieldMobileWidget extends StatelessWidget {
  final String labelText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final Widget? icon;
  final Widget? suffixIcon;

  const TextFormFieldMobileWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.start,
      cursorColor: buttonColor,
      style: const TextStyle(
        fontSize: 16,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        labelText: labelText,
        suffixText: "| +98",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: const TextStyle(
          fontFamily: 'irs',
          color: primary2Color,
        ),
        counter: const SizedBox.shrink(),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'لطفا شماره را صحیح وارد کنید';
        }
        if (controller.text[controller.text.length - 1] != ' ') {
          controller.text = (controller.text + '');
        }
        if (controller.selection ==
            TextSelection.fromPosition(
                TextPosition(offset: controller.text.length - 1))) {}

      },
    );
  }
}
