import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:you_app/cubit/auth_cubit.dart";
import "package:you_app/cubit/gender_cubit.dart";
import "package:you_app/cubit/get_profile_cubit.dart";
import "package:you_app/cubit/height_cubit.dart";
import "package:you_app/cubit/page_cubit.dart";
import "package:you_app/cubit/register_cubit.dart";
import "package:you_app/cubit/second_visibility_cubit.dart";
import "package:you_app/cubit/select_image_cubit.dart";
import "package:you_app/cubit/sign_in_button_cubit.dart";
import "package:you_app/cubit/sign_up_button_cubit.dart";
import "package:you_app/cubit/update_profile_cubit.dart";
import "package:you_app/cubit/visibility_cubit.dart";
import "package:you_app/cubit/weight_cubit.dart";
import "package:you_app/models/user_model.dart";
import "package:you_app/services/session.dart";
import "package:you_app/ui/pages/about_page.dart";
import "package:you_app/ui/pages/interest_form_page.dart";
import "package:you_app/ui/pages/login_page.dart";
import "package:you_app/ui/pages/sign_up_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateProfileCubit(),
        ),
        BlocProvider(
          create: (context) => SignInButtonCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpButtonCubit(),
        ),
        BlocProvider(
          create: (context) => VisibilityCubit(),
        ),
        BlocProvider(
          create: (context) => SecondVisibilityCubit(),
        ),
        BlocProvider(
          create: (context) => GetProfileCubit(),
        ),
        BlocProvider(
          create: (context) => SelectImageCubit(),
        ),
        BlocProvider(
          create: (context) => GenderCubit(),
        ),
        BlocProvider(
          create: (context) => HeightCubit(),
        ),
        BlocProvider(
          create: (context) => WeightCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => LoginPage(),
          "/sign-up": (context) => const SignUpPage(),
          "/interest-form": (context) => const InterestFormPage(),
          "/about": (context) => AboutPage(),
        },
      ),
    );
  }
}
