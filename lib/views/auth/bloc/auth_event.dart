part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class GoogleSignInEvent extends AuthEvent {}

@immutable
final class SignOutEvent extends AuthEvent {}

@immutable
final class UserStatusEvent extends AuthEvent {}
