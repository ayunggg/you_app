import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/cubit/visibility_cubit.dart';
import 'package:you_app/theme/theme.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String? hints;
  final bool? obsecure;
  final Function()? onComplete;
  final Function(String)? onChange;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final Widget? suffixIcon;

  const TextFormFieldCustom({
    super.key,
    this.hints,
    this.onComplete,
    this.onChange,
    this.textEditingController,
    this.initialValue,
    this.suffixIcon,
    this.obsecure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: const Color(0x0fffffff),
      ),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<VisibilityCubit, bool>(
              builder: (context, state) {
                return TextFormField(
                  controller: textEditingController,
                  onEditingComplete: onComplete,
                  onChanged: onChange,
                  initialValue: initialValue,
                  obscureText: obsecure == true ? state : false,
                  decoration: InputDecoration(
                    hintText: hints,
                    hintStyle: medium.copyWith(
                      fontSize: 13,
                      color: white30,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 18,
                    ),
                    border: InputBorder.none,
                    suffixIcon: suffixIcon,
                  ),
                  style: medium.copyWith(
                    fontSize: 13,
                    color: white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
