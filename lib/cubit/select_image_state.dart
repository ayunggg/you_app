part of 'select_image_cubit.dart';

sealed class SelectImageState extends Equatable {
  const SelectImageState();

  @override
  List<Object> get props => [];
}

final class SelectImageInitial extends SelectImageState {}

final class SelectImageLoading extends SelectImageState {}

final class SelectImageSuccess extends SelectImageState {
  final String file;

  const SelectImageSuccess(this.file);

  @override
  // TODO: implement props
  List<Object> get props => [file];
}
