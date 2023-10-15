part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

@immutable
final class AuthInitial extends AuthState {}

@immutable
final class AuthLoading extends AuthState {}

@immutable
final class AuthSuccess extends AuthState {
  const AuthSuccess({this.userID});

  final String? userID;

  @override
  List<Object> get props => [super.props, userID!];
}

@immutable
final class AuthFailure extends AuthState {
  const AuthFailure({required this.error});

  final String error;

  @override
  List<Object> get props => [super.props, error];
}
