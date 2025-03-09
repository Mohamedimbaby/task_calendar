import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      // This would normally call an API, but for now we'll just mock a response
      await Future.delayed(const Duration(seconds: 1));

      // In a real app, validate credentials here
      if (username.isNotEmpty && password.isNotEmpty) {
        return Right(User(
          id: '1',
          email: username.contains('@') ? username : '$username@example.com',
          username: username,
        ));
      } else {
        return Left(AuthFailure('Invalid credentials'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      // Mock implementation
      await Future.delayed(const Duration(seconds: 1));
      return Right(User(
        id: '2',
        email: 'google_user@example.com',
        username: 'Google User',
      ));
    } catch (e) {
      return Left(AuthFailure('Google login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithFacebook() async {
    try {
      // Mock implementation
      await Future.delayed(const Duration(seconds: 1));
      return Right(User(
        id: '3',
        email: 'facebook_user@example.com',
        username: 'Facebook User',
      ));
    } catch (e) {
      return Left(AuthFailure('Facebook login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithApple() async {
    try {
      // Mock implementation
      await Future.delayed(const Duration(seconds: 1));
      return Right(User(
        id: '4',
        email: 'apple_user@example.com',
        username: 'Apple User',
      ));
    } catch (e) {
      return Left(AuthFailure('Apple login failed: ${e.toString()}'));
    }
  }
}
