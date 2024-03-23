import 'dart:async';

import 'package:budget/repos/repos.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepo}) : super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthRemoveRequested>(_onAuthRemoveRequested);

    authStatusSubscription = authRepo.status.listen(
      (status) => add(AuthStatusChanged(status)),
    );
  }

  final AuthRepo authRepo;
  late StreamSubscription<AuthStatus> authStatusSubscription;

  @override
  Future<void> close() {
    authStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthStatusChanged(event, emit) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        return emit(const AuthState.authenticated());
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthLogoutRequested(event, emit) {
    authRepo.logOut();
  }

  void _onAuthRemoveRequested(event, emit) {
    authRepo.removeUser();
  }
}
