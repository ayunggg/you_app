import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/cubit/auth_cubit.dart';
import 'package:you_app/cubit/sign_in_button_cubit.dart';
import 'package:you_app/cubit/visibility_cubit.dart';
import 'package:you_app/services/session.dart';
import 'package:you_app/theme/theme.dart';
import 'package:you_app/ui/widgets/button_front.dart';
import 'package:you_app/ui/widgets/button_front_disabled.dart';
import 'package:you_app/ui/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(milliseconds: 500), () async {
      try {
        String user = await SessionManager().getStringValuesSF();
        if (user.isNotEmpty) {
          const Center(
            child: CircularProgressIndicator(),
          );
          Navigator.pushNamedAndRemoveUntil(context, "/about", (route) => false,
              arguments: {
                "token": user,
              });
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please, Re-Login")));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(context),
              createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 114,
        ),
        Text(
          "Login",
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
          onChange: (value) {
            context
                .read<SignInButtonCubit>()
                .setButtonSignIn(emailController, passwordController);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormFieldCustom(
          hints: "Enter Password",
          obsecure: true,
          textEditingController: passwordController,
          onChange: (value) {
            context
                .read<SignInButtonCubit>()
                .setButtonSignIn(emailController, passwordController);
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
          height: 25,
        ),
        BlocBuilder<SignInButtonCubit, bool>(
          builder: (context, stateC) {
            print(stateC);
            if (stateC == false) {
              return const ButtonFrontDisabled(title: "Login");
            }
            return BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  if (state.token == "User not found") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.token),
                      ),
                    );
                  } else if (state.token == "Incorrect password") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.token),
                      ),
                    );
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/about", (route) => false,
                        arguments: {
                          "token": state.token,
                        });
                  }
                } else if (state is AuthFailed) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.e)));
                }
              },
              builder: (context, state) {
                return ButtonFront(
                  title: "Login",
                  onTap: () {
                    context.read<AuthCubit>().AuthSignIn(
                        email: emailController.text,
                        password: passwordController.text);
                  },
                );
              },
            );
          },
        )
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
            "No account?",
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
              Navigator.pushNamed(context, "/sign-up");
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
                "Register here",
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
