import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final User? user;
  final String? errorMessage;
  final bool isPasswordVisible;
  final bool isFormValid;
  final String username;
  final String password;

  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.errorMessage,
    this.isPasswordVisible = false,
    this.isFormValid = false,
    this.username = '',
    this.password = '',
  });

  LoginState copyWith({
    LoginStatus? status,
    User? user,
    String? errorMessage,
    bool? isPasswordVisible,
    bool? isFormValid,
    String? username,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isFormValid: isFormValid ?? this.isFormValid,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        errorMessage,
        isPasswordVisible,
        isFormValid,
        username,
        password,
      ];
}
