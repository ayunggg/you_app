import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/cubit/update_profile_cubit.dart';
import 'package:you_app/models/user_model.dart';

import 'package:you_app/theme/theme.dart';
import 'package:you_app/ui/widgets/text_form_field.dart';

import '../../cubit/get_profile_cubit.dart';

class InterestFormPage extends StatelessWidget {
  const InterestFormPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    final args = ModalRoute.of(context)!.settings.arguments;

    context.read<GetProfileCubit>().getProfile(args.toString());

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/bg-front.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<GetProfileCubit, GetProfileState>(
          builder: (context, state) {
            if (state is GetProfileSuccess) {
              return ListView(
                padding: const EdgeInsets.only(left: 18, right: 20),
                children: [
                  header(context, state.userModel, textEditingController,
                      args.toString()),
                  textInterest(),
                  formInterst(textEditingController, state.userModel),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

header(
  BuildContext context,
  UserModel userModel,
  TextEditingController textEditingController,
  String token,
) {
  return Container(
    margin: const EdgeInsets.only(top: 80),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Back Button
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: white,
                size: 14,
              ),
            ),
            const SizedBox(
              width: 10,
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
        //SAVE BUTTON
        BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/about", (route) => false,
                  arguments: {
                    "token": token,
                  });
            }
          },
          builder: (context, state) {
            return InkWell(
              onTap: () {
                print(userModel.interest!.map((e) => e.toString()).toList());
                context.read<UpdateProfileCubit>().updateInterest(
                      token,
                      userModel,
                    );
              },
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 155, 255, 242),
                      Color.fromARGB(255, 153, 249, 249),
                      Color.fromARGB(255, 0, 164, 182),
                    ], // Warna gradient
                    begin: Alignment.topLeft, // Posisi awal gradient
                    end: Alignment.bottomRight, // Posisi akhir gradient
                    tileMode: TileMode.clamp, // Mode tile (opsional)
                  ).createShader(bounds);
                },
                child: Text(
                  "Save",
                  style: medium.copyWith(
                    fontSize: 14,
                    color: white,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

textInterest() {
  return Container(
    margin: const EdgeInsets.only(top: 74, left: 17),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              begin: Alignment.bottomLeft, // Posisi awal gradient
              end: Alignment.topRight, // Posisi akhir gradient
              tileMode: TileMode.clamp, // Mode tile (opsional)
            ).createShader(bounds);
          },
          child: Text(
            "Tell everyone about yourself",
            style: bold.copyWith(
              fontSize: 14,
              color: white,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "What interest you?",
          style: bold.copyWith(
            fontSize: 20,
            color: white,
          ),
        ),
      ],
    ),
  );
}

formInterst(TextEditingController textEditingController, UserModel userModel) {
  return Column(
    children: [
      Stack(
        children: [
          BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            builder: (context, state) {
              return TextFormFieldCustom(
                textEditingController: textEditingController,
                onComplete: () {
                  context
                      .read<UpdateProfileCubit>()
                      .addInterest(userModel, textEditingController.text);
                  print("INTERESTT USER MODEL");
                  print(userModel.interest);

                  textEditingController.clear();

                  textEditingController.selection = TextSelection.fromPosition(
                    TextPosition(
                      offset: textEditingController.text.length,
                    ),
                  );
                },
              );
            },
          ),
          BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
              builder: (context, state) {
            if (state is UpdateProfileAddInterest) {
              Wrap(
                children: userModel.interest!.map((e) {
                  return Container(
                    height: 31,
                    margin: const EdgeInsets.only(right: 8, top: 8),
                    decoration: BoxDecoration(
                      color: white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(e.toString()),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<UpdateProfileCubit>()
                                .removeInterest(userModel, e);
                            print("STATE SETELAH DI REMOVE");
                            print(state);
                          },
                          child: const Icon(
                            Icons.close_outlined,
                            size: 10,
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }
            if (state is UpdateProfileRemoveInterest) {}
            return userModel.interest!.isNotEmpty
                ? Wrap(
                    children: userModel.interest!.map((e) {
                      return Container(
                        height: 31,
                        margin: const EdgeInsets.only(right: 8, top: 8),
                        decoration: BoxDecoration(
                          color: white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(e.toString()),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<UpdateProfileCubit>()
                                    .removeInterest(userModel, e);
                                print("STATE SETELAH DI REMOVE");
                                print(state);
                              },
                              child: const Icon(
                                Icons.close_outlined,
                                size: 10,
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox();
          })
        ],
      ),
    ],
  );
}
