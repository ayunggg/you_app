import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/services/auth_services.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  AuthSignUp(
      {required String email,
      required String username,
      required String password}) async {
    try {
      emit(RegisterLoading());

      String message = await AuthService()
          .signUp(email: email, username: username, password: password);
      print("PESAN SIGN UP");
      print(message);
      print(state);
      emit(RegisterSuccess(message));
    } catch (e) {
      print("PESAN SIGN UP ERROR");
      print(e);
      print(state);
      emit(RegisterFailed(e.toString()));
    }
  }
}
