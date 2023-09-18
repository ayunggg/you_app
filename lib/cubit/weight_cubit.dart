import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class WeightCubit extends Cubit<String> {
  WeightCubit() : super("");

  void setWeight() {
    emit("Kg");
  }
}
