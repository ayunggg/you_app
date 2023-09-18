import 'package:flutter/material.dart';
import 'package:you_app/theme/theme.dart';

class TagProfile extends StatelessWidget {
  final String? icUrl;
  final String? title;
  const TagProfile({
    super.key,
    this.icUrl,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: white.withOpacity(0.1),
          ),
          child: Row(
            children: [
              Image.asset(
                "$icUrl",
                width: 20,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "$title",
                style: semiBold.copyWith(
                  fontSize: 14,
                  color: white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
