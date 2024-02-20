import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/repositories/user_repository.dart';

import '../../../core/error/failures.dart';
import '../../entities/user/user.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  SignUpUseCase({required this.userRepository});
  final UserRepository userRepository;

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await userRepository.signUp(params);
  }
}

class SignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  const SignUpParams(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}
