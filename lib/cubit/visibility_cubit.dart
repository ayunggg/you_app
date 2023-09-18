import 'package:bloc/bloc.dart';

class VisibilityCubit extends Cubit<bool> {
  VisibilityCubit() : super(true);

  setVisible() {
    emit(false);
  }

   setInvisible() {
    emit(true);
  }
}
