import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(const LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void usernameChanged(String username) {
    emit(state.copyWith(
      username: username,
      isFormValid: _validateForm(username, state.password),
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      isFormValid: _validateForm(state.username, password),
    ));
  }

  bool _validateForm(String username, String password) {
    // Username validation
    bool isUsernameValid = username.isNotEmpty;

    // Email validation if it contains @
    if (username.contains('@')) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      isUsernameValid = emailRegex.hasMatch(username);
    }

    // Password validation - simple check for minimum length
    bool isPasswordValid = password.length >= 6;

    return isUsernameValid && isPasswordValid;
  }

  Future<void> login(String username, String password) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: LoginStatus.loading));

    final result = await authRepository.login(username, password);

    result.fold(
      (failure) => emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        status: LoginStatus.success,
        user: user,
      )),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await authRepository.loginWithGoogle();

    result.fold(
      (failure) => emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        status: LoginStatus.success,
        user: user,
      )),
    );
  }

  Future<void> loginWithFacebook() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await authRepository.loginWithFacebook();

    result.fold(
      (failure) => emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        status: LoginStatus.success,
        user: user,
      )),
    );
  }

  Future<void> loginWithApple() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await authRepository.loginWithApple();

    result.fold(
      (failure) => emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        status: LoginStatus.success,
        user: user,
      )),
    );
  }
}
