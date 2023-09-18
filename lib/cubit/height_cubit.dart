import 'package:bloc/bloc.dart';

class HeightCubit extends Cubit<String> {
  HeightCubit() : super("");

  void setHeight() {
    emit("Cm");
  }
}
