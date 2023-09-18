part of 'update_profile_cubit.dart';

sealed class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileSuccess extends UpdateProfileState {
  final UserModel userModel;

  const UpdateProfileSuccess(this.userModel);

  @override
  // TODO: implement props
  List<Object> get props => [userModel];
}

final class UpdateProfileFailed extends UpdateProfileState {
  final String e;

  const UpdateProfileFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

final class UpdateProfileRemoveInterest extends UpdateProfileState {
  final bool interest;

  const UpdateProfileRemoveInterest(this.interest);

  @override
  // TODO: implement props
  List<Object> get props => [interest];
}

final class UpdateProfileAddInterest extends UpdateProfileState {
  final String interest;

  const UpdateProfileAddInterest(this.interest);

  @override
  // TODO: implement props
  List<Object> get props => [interest];
}
