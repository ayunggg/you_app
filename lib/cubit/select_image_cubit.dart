import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/shared/methods.dart';

part 'select_image_state.dart';

class SelectImageCubit extends Cubit<SelectImageState> {
  SelectImageCubit() : super(SelectImageInitial());

  getImage() async {
    try {
      emit(SelectImageLoading());

      String? file = await selectImage();

      emit(SelectImageSuccess(file!));
    } catch (e) {
      rethrow;
    }
  }
}
