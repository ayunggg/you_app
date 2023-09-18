import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/models/user_model.dart';
import 'package:you_app/shared/methods.dart';
import 'package:you_app/ui/widgets/about_card_widgets/tag_profile.dart';

import '../../../theme/theme.dart';

class FilledImage extends StatelessWidget {
  final UserModel userModel;
  final String? imgUrl;
  final String? gender;
  final String? horoscope;

  const FilledImage({
    super.key,
    this.imgUrl,
    this.horoscope,
    this.gender,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    final String umur = formatDate(userModel.birthday!).toString();
    TextEditingController horoscope = TextEditingController();
    TextEditingController zodiac = TextEditingController();

    userModel.birthday != null
        ? getHoroscope(userModel.birthday!, horoscope)
        : "";

    userModel.birthday != null ? getZodiac(zodiac, userModel.birthday!) : "";
    return Stack(
      children: [
        Container(
          height: 210,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 8, right: 8, top: 28),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kBackgroundCardProfile,
            image: DecorationImage(
              image: AssetImage(
                imgUrl!,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gender != ''
                  ? const SizedBox(
                      height: 87,
                    )
                  : const SizedBox(
                      height: 107,
                    ),
              Text(
                "@${userModel.username}, $umur",
                style: bold.copyWith(
                  fontSize: 16,
                  color: white,
                ),
              ),
              gender != ""
                  ? const SizedBox(
                      height: 6,
                    )
                  : const SizedBox(),
              gender != ""
                  ? Text(
                      gender!,
                      style: medium.copyWith(
                        fontSize: 13,
                        color: white,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Container(
          height: 210,
          margin: const EdgeInsets.only(left: 8, right: 8, top: 28),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.076),
                Colors.black.withOpacity(0),
                Colors.black,
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 18),
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              Row(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
