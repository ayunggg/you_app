import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/cubit/gender_cubit.dart';
import 'package:you_app/cubit/get_profile_cubit.dart';
import 'package:you_app/cubit/height_cubit.dart';
import 'package:you_app/cubit/page_cubit.dart';
import 'package:you_app/cubit/select_image_cubit.dart';
import 'package:you_app/cubit/update_profile_cubit.dart';
import 'package:you_app/cubit/weight_cubit.dart';
import 'package:you_app/models/user_model.dart';
import 'package:you_app/services/session.dart';
import 'package:you_app/shared/methods.dart';
import 'package:you_app/theme/theme.dart';
import 'package:you_app/ui/widgets/about_card_widgets/empty_image.dart';
import 'package:you_app/ui/widgets/about_card_widgets/filled_image.dart';
import 'package:you_app/ui/widgets/about_card_widgets/gender.dart';
import 'package:you_app/ui/widgets/form_about.dart';

class AboutPage extends StatelessWidget {
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController horoscope = TextEditingController();
  final TextEditingController zodiac = TextEditingController();
  final TextEditingController displayName = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  String? gender;
  String? imgUrl;
  AboutPage({
    super.key,
    this.gender = '',
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    // INISIASI PAGE CUBIT
    PageCubit pageCubit = context.read<PageCubit>();

    // MENGAMBIL DATA DARI ARGUMEN YANG DILEMPAR DARI SCREEN SEBELUMNYA
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Menjalankan Function GetProfile Sebelum Widget Di Build
    context.read<GetProfileCubit>().getProfile(args['token'].toString());

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocConsumer<GetProfileCubit, GetProfileState>(
        listener: (context, state) {
          if (state is GetProfileFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.e)));
          }
        },
        builder: (context, state) {
          if (state is GetProfileSuccess) {
            return ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                header(context, state.userModel),
                profileCard(context, state.userModel),
                BlocBuilder<PageCubit, int>(
                  builder: (context, stateC) {
                    return stateC == 1
                        ? aboutForm(pageCubit, context, state.userModel.token!)
                        : aboutCard(pageCubit);
                  },
                ),
                interest(context, state.userModel, state.userModel.token!),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Container header(
    BuildContext context,
    UserModel userModel,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: white,
                    size: 14,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  "Back",
                  style: bold.copyWith(
                    fontSize: 14,
                    color: white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              child: Text(
            "@${userModel.username}",
            style: bold.copyWith(
              fontSize: 14,
              color: white,
            ),
          )),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: kBackgroundCard,
                            child: SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Hi, ${userModel.name}",
                                    style: medium.copyWith(
                                      fontSize: 18,
                                      color: white,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      SessionManager().deleteSession();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/", (route) => false);
                                    },
                                    child: Text(
                                      "Logout",
                                      style: medium.copyWith(
                                        fontSize: 14,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    size: 25,
                    color: white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  profileCard(BuildContext context, UserModel userModel) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return args['imgUrl'] == null
        ? EmptyImage(userModel: userModel)
        : FilledImage(
            userModel: userModel,
            imgUrl: args['imgUrl'].toString(),
            gender: args['gender'].toString(),
          );
  }

  Container aboutCard(PageCubit pageCubit) {
    return Container(
      height: 120,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 24),
      padding: const EdgeInsets.only(top: 14, bottom: 23, right: 14, left: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBackgroundCardProfile,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "About",
                style: bold.copyWith(
                  fontSize: 14,
                  color: white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  pageCubit.newView();
                },
                child: Image.asset(
                  "assets/ic-pencil.png",
                  width: 17,
                  color: white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Add in your your to help others know you \nbetter",
            style: medium.copyWith(
              fontSize: 14,
              color: white.withOpacity(
                0.52,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container interest(BuildContext context, UserModel userModel, String token) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 24),
      padding: const EdgeInsets.only(top: 14, bottom: 23, right: 14, left: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBackgroundCardProfile,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Interest",
                style: bold.copyWith(
                  fontSize: 14,
                  color: white,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/interest-form",
                      arguments: token);
                },
                child: Image.asset(
                  "assets/ic-pencil.png",
                  width: 17,
                  color: white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          userModel.interest!.isNotEmpty
              ? Wrap(
                  children: userModel.interest!.map((e) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      margin: const EdgeInsets.only(right: 12, bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: white.withOpacity(0.6),
                      ),
                      child: Text(e.toString()),
                    );
                  }).toList(),
                )
              : Text(
                  "Add in your interest to find a better match",
                  style: medium.copyWith(
                    fontSize: 14,
                    color: white.withOpacity(
                      0.52,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container aboutForm(PageCubit pageCubit, BuildContext context, String token) {
    const List<String> genderList = <String>[
      "Gender",
      "Laki - Laki",
      "Perempuan"
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 24),
      padding: const EdgeInsets.only(top: 14, bottom: 40, right: 20, left: 27),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBackgroundCardProfile,
      ),
      child: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          if (state is GetProfileSuccess) {
            String date = state.userModel.birthday != null
                ? state.userModel.birthday!
                : "";
            //Set Default Value DisplayName Controller
            displayName.text = state.userModel.username!.isNotEmpty
                ? state.userModel.username!
                : "";
            //Set Default Value Birthday Controller
            birthdayController.text = state.userModel.birthday != null
                ? state.userModel.birthday!
                : "";
            //Set Default Value Horoscope Controller
            birthdayController.text != ""
                ? getHoroscope(birthdayController.text, horoscope)
                : "";
            //Set Default Value Zodiac Controller
            birthdayController.text != ""
                ? getZodiac(zodiac, birthdayController.text)
                : "";
            //Set Default Value Height Controller
            height.text = state.userModel.height != null
                ? state.userModel.height.toString()
                : "";
            //Set Default Value Horoscope Controller
            weight.text = state.userModel.weight != null
                ? state.userModel.weight.toString()
                : "";
            return Column(
              children: [
                // Top Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About",
                      style: bold.copyWith(
                        fontSize: 14,
                        color: white,
                      ),
                    ),
                    //Save & Update Button
                    BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                      listener: (context, current) {
                        if (current is UpdateProfileFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(current.toString())));
                        } else if (current is UpdateProfileSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/about', (route) => false,
                              arguments: {
                                "token": token,
                                "imgUrl": imgUrl,
                                "gender": gender,
                              });
                          context.read<PageCubit>().prevViwew();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("SUKSES UPDATE PROFILE")));
                        }
                      },
                      builder: (context, current) {
                        return InkWell(
                          onTap: () async {
                            await context
                                .read<UpdateProfileCubit>()
                                .updateProfile(
                                  token,
                                  displayName.text,
                                  birthdayController.text,
                                  num.parse(weight.text),
                                  num.parse(height.text),
                                  [],
                                  horoscope.text,
                                  zodiac.text,
                                  gender != null ? gender! : "",
                                  imgUrl != null ? imgUrl! : "",
                                );
                          },
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFF3EDA6),
                                  Color(0xFFF8FAE5),
                                  Color(0xFFD5BE88),
                                  Color(0xFFF8FAE5),
                                ], // Warna gradient
                                begin: Alignment
                                    .bottomLeft, // Posisi awal gradient
                                end:
                                    Alignment.topRight, // Posisi akhir gradient
                                tileMode:
                                    TileMode.clamp, // Mode tile (opsional)
                              ).createShader(bounds);
                            },
                            child: Text(
                              "Save & Update",
                              style: medium.copyWith(
                                color: white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 31,
                ),
                // Add Image Button
                BlocBuilder<SelectImageCubit, SelectImageState>(
                  builder: (context, state) {
                    if (state is SelectImageSuccess) {
                      imgUrl = state.file;
                      return Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(17),
                            color: const Color(0x14ffffff),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () {
                                context.read<SelectImageCubit>().getImage();
                              },
                              child: Container(
                                width: 57,
                                height: 57,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: const Color(0x14ffffff),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: Image.file(
                                    File(
                                      state.file,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Add Image",
                            style: medium.copyWith(
                              color: white,
                            ),
                          )
                        ],
                      );
                    }
                    if (state is SelectImageInitial) {
                      return Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(17),
                            color: const Color(0x14ffffff),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () async {
                                await context
                                    .read<SelectImageCubit>()
                                    .getImage();
                              },
                              child: Container(
                                width: 57,
                                height: 57,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: const Color(0x14ffffff),
                                ),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Color(0xFFF3EDA6),
                                              Color(0xFFF8FAE5),
                                              Color(0xFFD5BE88),
                                              Color(0xFFF8FAE5),
                                            ], // Warna gradient
                                            begin: Alignment
                                                .bottomLeft, // Posisi awal gradient
                                            end: Alignment
                                                .topRight, // Posisi akhir gradient
                                            tileMode: TileMode
                                                .clamp, // Mode tile (opsional)
                                          ).createShader(bounds);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: white,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Add Image",
                            style: medium.copyWith(
                              color: white,
                            ),
                          )
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                //Form Section Display Name
                Container(
                  margin: const EdgeInsets.only(top: 29),
                  child: FormAbout(
                    hintText: "Enter name",
                    sizedBoxWidth: 29,
                    title: "Display name",
                    controller: displayName,
                  ),
                ),
                //Form Section Gender
                gender_widget(
                  list: genderList,
                  onChange: (value) {
                    gender = value;
                    context.read<GenderCubit>().setGender(gender!);
                    print("GENDER OBJECT");
                    print(gender);
                  },
                ),

                //Form Section Birthday
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        date = await selectDate(context, birthdayController);
                        getHoroscope(date, horoscope);
                        getZodiac(zodiac, date);
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: FormAbout(
                          title: "Birthday",
                          hintText: "DD MM YYYY",
                          sizedBoxWidth: 59,
                          controller: birthdayController,
                        ),
                      ),
                    ),
                  ),
                ),

                //Form Section Horoscope
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FormAbout(
                      title: "Horoscope",
                      hintText: "--",
                      sizedBoxWidth: 44,
                      enabled: true,
                      controller: horoscope,
                    ),
                  ),
                ),
                //Form Section Zodiac
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FormAbout(
                      title: "Zodiac",
                      hintText: "--",
                      sizedBoxWidth: 70,
                      enabled: true,
                      controller: zodiac,
                    ),
                  ),
                ),
                //Form Section Height
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: BlocBuilder<HeightCubit, String>(
                    builder: (context, state) {
                      return FormAbout(
                        hintText: "Add Height",
                        sizedBoxWidth: 70,
                        title: "Height",
                        textInputType: TextInputType.number,
                        controller: height,
                        onChanged: (_) {
                          context.read<HeightCubit>().setHeight();
                        },
                        suffix:
                            state != "" ? const Text("Cm") : const SizedBox(),
                      );
                    },
                  ),
                ),
                //Form Section Wieght
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: BlocBuilder<WeightCubit, String>(
                    builder: (context, state) {
                      return FormAbout(
                        hintText: "Add Weight",
                        sizedBoxWidth: 68,
                        title: "Weight",
                        textInputType: TextInputType.number,
                        controller: weight,
                        onChanged: (_) {
                          context.read<WeightCubit>().setWeight();
                        },
                        suffix:
                            state != "" ? const Text("Kg") : const SizedBox(),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
