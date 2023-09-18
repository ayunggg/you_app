part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String token;

  const AuthSuccess(this.token);

  @override
  // TODO: implement props
  List<Object> get props => [token];
}

final class AuthFailed extends AuthState {
  final String e;

  const AuthFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e];
}
