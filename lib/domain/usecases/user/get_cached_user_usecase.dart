import 'package:dartz/dartz.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';
import 'package:eshoes_clean_arch/domain/entities/user/user.dart';
import 'package:eshoes_clean_arch/domain/repositories/user_repository.dart';

class GetCachedUserUseCase implements UseCase<User, NoParams> {
  GetCachedUserUseCase({required this.repository});
  final UserRepository repository;
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCachedUser();
  }
}
