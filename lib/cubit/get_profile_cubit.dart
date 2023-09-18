import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/models/interest_model.dart';
import 'package:you_app/models/user_model.dart';
import 'package:you_app/services/user_service.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileInitial());

  List<Interest> interest = [];

   getProfile(String token) async {
    try {
      emit(GetProfileLoading());

      UserModel userModel = await UserService().getProfile(token);

     
      emit(GetProfileSuccess(userModel));
    } catch (e) {
      emit(GetProfileFailed(e.toString()));
    }
  }

 
}
