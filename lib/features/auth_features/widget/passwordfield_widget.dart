import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class PasswordFieldWidget extends StatefulWidget {
  final String labelText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final Widget? icon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const PasswordFieldWidget({
    super.key,
    required this.labelText,
    required this.icon,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.suffixIcon,
    required this.prefixIcon,
  });

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      textAlign: TextAlign.start,
      cursorColor: primaryColor,
      style: theme.textTheme.bodyMedium,
      textInputAction: widget.textInputAction,
      minLines: 1,
      controller: widget.controller,
      obscureText: !isShow,
      decoration: InputDecoration(
        border: InputBorder.none,
        counter: const SizedBox.shrink(),
        prefixIcon: widget.icon,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontFamily: 'irs',
          color: primary2Color,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
          icon: Icon(
            isShow ? Icons.visibility : Icons.visibility_off,
          ),
        ),
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
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی‌تواند خالی باشد';
        }
        if (value.length < 8) {
          return 'رمز عبور باید بین ۸ تا ۷۲ کاراکتر باشد';
        }
        return null;
      },
    );
  }
}
