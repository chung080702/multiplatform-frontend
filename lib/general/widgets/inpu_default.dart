import 'package:flutter/material.dart';
import 'package:multiplatform_app/general/constants/app_color.dart';
import 'package:multiplatform_app/general/constants/app_text_style.dart';

class InputDefault extends StatelessWidget {
  const InputDefault(
      {super.key,
      required this.editingController,
      required this.hintText,
      required this.labelText,
      required this.obscureText,
      required this.validator,
      required this.textInputType,
      this.onTap,
      required this.readOnly});

  final TextEditingController editingController;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final String? Function(String?) validator;
  final TextInputType textInputType;
  final Future<void> Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(labelText, style: AppTextStyle.textStyle_14_600_20),
        ),
        TextFormField(
          keyboardType: textInputType,
          onTap: onTap,
          readOnly: readOnly,
          obscureText: obscureText,
          style: const TextStyle(
                  color: AppColor.grey,
                  decoration: TextDecoration.none,
                  decorationThickness: 0)
              .merge(AppTextStyle.textStyle_12_600_18),
          validator: validator,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              hintText: hintText,
              filled: true,
              fillColor: AppColor.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        )
      ],
    );
  }
}
