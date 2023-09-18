part of 'get_profile_cubit.dart';

sealed class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

final class GetProfileInitial extends GetProfileState {}

final class GetProfileLoading extends GetProfileState {}

final class GetProfileSuccess extends GetProfileState {
  final UserModel userModel;

  const GetProfileSuccess(this.userModel);

  @override
  // TODO: implement props
  List<Object> get props => [userModel];
}



final class GetProfileFailed extends GetProfileState {
  final String e;

  const GetProfileFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e];
}
