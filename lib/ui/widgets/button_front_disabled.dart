import 'package:flutter/material.dart';
import 'package:you_app/theme/theme.dart';

class ButtonFrontDisabled extends StatelessWidget {
  final String title;
  const ButtonFrontDisabled({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 48,
      height: 48,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width - 48,
                height: 48,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF62CDCB),
                      Color(0xFF4599DB),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: bold.copyWith(
                      fontSize: 13,
                      color: white,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width - 48,
                height: 48,
                color: const Color.fromARGB(71, 0, 0, 0),
              )
            ],
          )
        ],
      ),
    );
  }
}
