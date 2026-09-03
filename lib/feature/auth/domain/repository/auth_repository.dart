import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String email,
    required String password,
    required name,
  });
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String eamail,
    required String password,
  });
}
