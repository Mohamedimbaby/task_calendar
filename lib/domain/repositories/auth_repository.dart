import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, User>> loginWithGoogle();
  Future<Either<Failure, User>> loginWithFacebook();
  Future<Either<Failure, User>> loginWithApple();
}
