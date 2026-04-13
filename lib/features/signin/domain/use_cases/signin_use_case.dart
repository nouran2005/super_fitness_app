import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';
import 'package:super_fitness_app/features/signin/domain/repositories/signin_repository.dart';

@injectable
class SigninUseCase {
  final SigninRepository signinRepository;

  SigninUseCase({required this.signinRepository});
  Future<ApiResult<SigninEntity>> execute(SigninPostModel loginPostEntity) =>
      signinRepository.signin(loginPostEntity);
}
