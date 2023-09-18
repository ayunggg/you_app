import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SignUpButtonCubit extends Cubit<bool> {
  SignUpButtonCubit() : super(false);

  setButtonSignUp(TextEditingController emailC, TextEditingController usernameC,
      TextEditingController passwordC, TextEditingController confirmC) {
    if (emailC.text.isNotEmpty &&
        usernameC.text.isNotEmpty &&
        passwordC.text.isNotEmpty &&
        confirmC.text.isNotEmpty) {
      emit(true);

      return true;
    } else {
      emit(false);
      print("FALSE JALAN");
      return false;
    }
  }

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
