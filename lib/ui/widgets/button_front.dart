import 'package:flutter/material.dart';
import 'package:you_app/theme/theme.dart';

class ButtonFront extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const ButtonFront({
    super.key,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 48,
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width - 48,
              height: 48,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF62CDCB),
                      Color(0xFF4599DB),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      spreadRadius: 0.10,
                      color: Color(0xFF62CDCB),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 4.0),
                    )
                  ]),
              child: Center(
                child: Text(
                  "$title",
                  style: bold.copyWith(
                    fontSize: 13,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
