import 'package:bloc/bloc.dart';

class PageCubit extends Cubit<int> {
  PageCubit() : super(0);

  void newView() {
    emit(state + 1);
  }

  void prevViwew() {
    emit(state - 1);
  }
}
