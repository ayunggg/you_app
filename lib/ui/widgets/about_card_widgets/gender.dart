import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/cubit/gender_cubit.dart';
import 'package:you_app/theme/theme.dart';

class gender_widget extends StatelessWidget {
  final Function(String?)? onChange;
  gender_widget({
    super.key,
    this.onChange,
    required this.list,
  });

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        height: 36,
        child: Row(
          children: [
            Text(
              "Gender:",
              style: medium.copyWith(
                fontSize: 13,
                color: white.withOpacity(
                  0.33,
                ),
              ),
            ),
            const SizedBox(
              width: 66,
            ),
            Expanded(
              child: BlocBuilder<GenderCubit, String>(
                builder: (context, state) {
                  return Container(
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0x0fd9d9d9),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DropdownButton<String>(
                        value: state,
                        dropdownColor: kBackgroundCard,
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: medium.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: onChange,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
