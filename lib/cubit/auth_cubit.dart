import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthSignIn(
      {required String email,
      String? username,
      required String password}) async {
    try {
      emit(AuthLoading());

      String token = await AuthService()
          .signIn(email: email, username: "", password: password);

      emit(AuthSuccess(token));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

 
}
