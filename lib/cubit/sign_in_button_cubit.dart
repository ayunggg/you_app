import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SignInButtonCubit extends Cubit<bool> {
  SignInButtonCubit() : super(false);

  setButtonSignIn(TextEditingController emailController,
      TextEditingController passwordController) {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      emit(true);
      print(state);
      return true;
    } else {
      emit(false);
      print(state);
      return false;
    }
  }
}
