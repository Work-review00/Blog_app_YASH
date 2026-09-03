import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String eamail,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String email,
    required String password,
    required name,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
    // TODO: implement signUpWithEmailPassword
    throw UnimplementedError();
  }
}
