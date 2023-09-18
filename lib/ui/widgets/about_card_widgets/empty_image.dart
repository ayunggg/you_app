import 'package:flutter/material.dart';
import 'package:you_app/models/user_model.dart';
import 'package:you_app/shared/methods.dart';
import 'package:you_app/theme/theme.dart';
import 'package:you_app/ui/widgets/about_card_widgets/tag_profile.dart';

class EmptyImage extends StatelessWidget {
  final UserModel userModel;
  const EmptyImage({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController horoscope = TextEditingController();
    TextEditingController zodiac = TextEditingController();

    userModel.birthday != null
        ? getHoroscope(userModel.birthday!, horoscope)
        : "";

    userModel.birthday != null ? getZodiac(zodiac, userModel.birthday!) : "";
    return Container(
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 28),
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBackgroundCardProfile,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "@${userModel.username}, ${userModel.birthday != null ? formatDate(userModel.birthday!) : ""}",
            style: bold.copyWith(
              fontSize: 16,
              color: white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          userModel.birthday != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TagProfile(
                      icUrl: "assets/ic-virgo.png",
                      title: horoscope.text,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    TagProfile(
                      icUrl: "assets/ic-pig.png",
                      title: zodiac.text,
                    ),
                  ],
                )
              : const SizedBox(),
          // Text(
          //   formatDate(userModel.birthday!),
          //   style: bold.copyWith(
          //     fontSize: 16,
          //     color: white,
          //   ),
          // ),
        ],
      ),
    );
  }
}
