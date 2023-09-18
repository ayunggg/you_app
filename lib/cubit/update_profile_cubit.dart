import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/cubit/get_profile_cubit.dart';
import 'package:you_app/models/interest_model.dart';
import 'package:you_app/models/user_model.dart';
import 'package:you_app/services/user_service.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  updateProfile(
    String token,
    String name,
    String birthday,
    num weight,
    num height,
    List<dynamic> interest,
    String horoscope,
    String zodiac,
    String gender,
    String imgUrl,
  ) async {
    try {
      emit(UpdateProfileLoading());

      UserModel user = await UserService().updateProfile(token, name, birthday,
          weight, height, interest, horoscope, zodiac, gender, imgUrl);

      emit(UpdateProfileSuccess(user));
    } catch (e) {
      print(e.toString());
      emit(UpdateProfileFailed(e.toString()));
    }
  }

  updateInterest(
    String token,
    UserModel userModel,
  ) async {
    try {
      emit(UpdateProfileLoading());

      UserModel user = await UserService().updateInterest(
        token,
        userModel,
      );

      emit(UpdateProfileSuccess(user));
    } catch (e) {
      emit(UpdateProfileFailed(e.toString()));
    }
  }

  void removeInterest(UserModel userModel, String value) {
    try {
      emit(UpdateProfileLoading());

      bool interest = userModel.interest!.remove(value);

      emit(UpdateProfileRemoveInterest(interest));
    } catch (e) {
      emit(UpdateProfileFailed(e.toString()));
    }
  }

  addInterest(UserModel userModel, String value) {
    try {
      emit(UpdateProfileLoading());

      userModel.interest!.add(value);

      emit(UpdateProfileAddInterest(value));
    } catch (e) {
      emit(UpdateProfileFailed(e.toString()));
    }
  }
}
