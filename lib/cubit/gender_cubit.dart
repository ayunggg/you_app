import 'package:bloc/bloc.dart';

class GenderCubit extends Cubit<String> {
  GenderCubit() : super("Gender");

   setGender(String value) {
    emit(value);
  }
}
