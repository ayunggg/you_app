// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/cubit/register_cubit.dart';
import 'package:you_app/cubit/second_visibility_cubit.dart';
import 'package:you_app/cubit/sign_up_button_cubit.dart';
import 'package:you_app/cubit/visibility_cubit.dart';
import 'package:you_app/services/auth_services.dart';
import 'package:you_app/ui/widgets/button_front_disabled.dart';
import 'package:you_app/ui/widgets/text_form_field_confirm.dart';

import '../../theme/theme.dart';
import '../widgets/button_front.dart';
import '../widgets/text_form_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              header(context, emailController, usernameController,
                  passwordController, confirmPasswordController),
              createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  header(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController usernameController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    SignUpButtonCubit btnC = context.read<SignUpButtonCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 84,
        ),
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
        const SizedBox(
          height: 60,
        ),

        //REGISTER SECTION
        Text(
          "Register",
          style: bold.copyWith(
            fontSize: 24,
            color: white,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        TextFormFieldCustom(
          hints: "Enter Email",
          textEditingController: emailController,
          onChange: (_) {
            btnC.setButtonSignUp(emailController, usernameController,
                passwordController, confirmPasswordController);
          },
        ),
        const SizedBox(
          height: 11,
        ),
        TextFormFieldCustom(
          hints: "Create Username",
          textEditingController: usernameController,
          onChange: (_) {
            btnC.setButtonSignUp(emailController, usernameController,
                passwordController, confirmPasswordController);
          },
        ),
        const SizedBox(
          height: 11,
        ),
        TextFormFieldCustom(
          hints: "Create Password",
          obsecure: true,
          textEditingController: passwordController,
          onChange: (_) {
            btnC.setButtonSignUp(emailController, usernameController,
                passwordController, confirmPasswordController);
          },
          suffixIcon: BlocBuilder<VisibilityCubit, bool>(
            builder: (context, state) {
              return state == true
                  ? IconButton(
                      onPressed: () {
                        context.read<VisibilityCubit>().setVisible();
                      },
                      icon: const Image(
                        image: AssetImage(
                          'assets/ic-eye.png',
                        ),
                        width: 21,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        context.read<VisibilityCubit>().setInvisible();
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        size: 21,
                      ),
                    );
            },
          ),
        ),

        const SizedBox(
          height: 11,
        ),
        TextFormFieldConfirmPassword(
          hints: "Confirm Password",
          obsecure: true,
          textEditingController: confirmPasswordController,
          onChange: (value) {
            btnC.setButtonSignUp(emailController, usernameController,
                passwordController, confirmPasswordController);
          },
          onComplete: () {
            if (passwordController.text != confirmPasswordController.text) {
              return ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text("Field Password dan Confrim Password Tidak Sesuai"),
                ),
              );
            }
          },
          suffixIcon: BlocBuilder<SecondVisibilityCubit, bool>(
            builder: (context, state) {
              return state == true
                  ? IconButton(
                      onPressed: () {
                        context.read<SecondVisibilityCubit>().setVisible();
                      },
                      icon: const Image(
                        image: AssetImage(
                          'assets/ic-eye.png',
                        ),
                        width: 21,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        context.read<SecondVisibilityCubit>().setInvisible();
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        size: 21,
                      ),
                    );
            },
          ),
        ),
        const SizedBox(
          height: 25,
        ),

        BlocBuilder<SignUpButtonCubit, bool>(
          builder: (context, state) {
            if (state == false) {
              return const ButtonFrontDisabled(title: "Register");
            }
            return BlocConsumer<RegisterCubit, RegisterState>(
              listener: (contextC, stateC) async {
                if (stateC is RegisterSuccess) {
                  if (stateC.message == "User has been created successfully") {
                    String token = await AuthService().signIn(
                        email: emailController.text,
                        username: "",
                        password: passwordController.text);

                    Navigator.pushNamedAndRemoveUntil(
                        context, '/about', (route) => false,
                        arguments: {"token": token});
                  }
                  if (stateC.message == "User already exists") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(stateC.message),
                      ),
                    );
                  }
                }
              },
              builder: (contextC, stateC) {
                if (stateC is RegisterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ButtonFront(
                  title: "Register",
                  onTap: () {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Field Password dan Confrim Password Tidak Sesuai"),
                        ),
                      );
                    } else {
                      context.read<RegisterCubit>().AuthSignUp(
                          email: emailController.text,
                          username: usernameController.text,
                          password: passwordController.text);
                    }
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  createAccount(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Have an account?",
            style: medium.copyWith(
              fontSize: 13,
              color: white,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/");
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
                  begin: Alignment.bottomLeft, // Posisi awal gradient
                  end: Alignment.topRight, // Posisi akhir gradient
                  tileMode: TileMode.clamp, // Mode tile (opsional)
                ).createShader(bounds);
              },
              child: Text(
                "Login here",
                style: medium.copyWith(
                  fontSize: 13,
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
