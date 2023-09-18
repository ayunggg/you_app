import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class FormAbout extends StatelessWidget {
  final String? title;
  final String? hintText;
  final double? sizedBoxWidth;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? initialValue;
  final bool enabled;
  final Function()? onComplete;
  final Function(String)? onFieldSubmitted;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final Widget? suffix;
  const FormAbout({
    super.key,
    this.title,
    this.hintText,
    this.sizedBoxWidth,
    this.onChanged,
    this.onTap,
    this.enabled = false,
    this.initialValue,
    this.onComplete,
    this.controller,
    this.onFieldSubmitted,
    this.textInputType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          style: medium.copyWith(
            fontSize: 13,
            color: white.withOpacity(
              0.33,
            ),
          ),
        ),
        SizedBox(
          width: sizedBoxWidth,
        ),
        Expanded(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0x0fd9d9d9),
            ),
            child: TextFormField(
              onEditingComplete: onComplete,
              readOnly: enabled,
              onTap: onTap,
              keyboardType: textInputType,
              controller: controller,
              onFieldSubmitted: onFieldSubmitted,
              textAlign: TextAlign.right,
              onChanged: onChanged,
              decoration: InputDecoration(
                suffix: suffix,
                hintText: hintText,
                hintTextDirection: TextDirection.rtl,
                hintStyle: medium.copyWith(
                  fontSize: 13,
                  color: white30,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 20,
                ),
                border: InputBorder.none,
              ),
              style: medium.copyWith(
                fontSize: 13,
                color: white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
