import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/user_repository.dart';

import '../../../core/error/failures.dart';
import '../../entities/user/user.dart';

class SignInUseCase implements UseCase<User, SignInParams> {
  SignInUseCase({
    required this.repository,
  });
  final UserRepository repository;

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(params);
  }
}

class SignInParams {
  final String username;
  final String password;
  const SignInParams({
    required this.username,
    required this.password,
  });
}
