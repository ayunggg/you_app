import 'package:bloc/bloc.dart';

class SecondVisibilityCubit extends Cubit<bool> {
  SecondVisibilityCubit() : super(true);

  setVisible() {
    emit(false);
    print("STATE SETVISIB $state");
    return false;
  }

  void setInvisible() {
    emit(true);
    print("STATE INVIS $state");
  }
}
