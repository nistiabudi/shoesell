import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';

import '../entities/user/user.dart';
import '../usecases/user/sign_in_usecase.dart';
import '../usecases/user/sign_up_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signIn(SignInParams params);

  Future<Either<Failure, User>> signUp(SignUpParams params);

  Future<Either<Failure, NoParams>> signOut();

  Future<Either<Failure, User>> getCachedUser();
}
