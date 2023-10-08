import 'dart:async';

import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/services/supabase_config.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<GoogleSignInEvent>(_signInWithGoogle);
    on<SignOutEvent>(_signOut);
    on<UserStatusEvent>(_userStatus);
  }

  final client = getIt<SupabaseConfig>().client;
  final _auth = MyAuth();

  FutureOr<void> _signInWithGoogle(
    GoogleSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithGoogle(
        client: client,
      );
      emit(AuthSuccess());
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  FutureOr<void> _signOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      emit(const AuthFailure(error: ''));
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  FutureOr<void> _userStatus(
    UserStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _auth.getCurrentUser();
      if (user == null) {
        emit(const AuthFailure(error: ''));
      } else {
        emit(AuthSuccess());
      }
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }
}