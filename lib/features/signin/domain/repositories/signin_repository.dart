// TODO: domain SigninRepository

import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';

abstract class SigninRepository {
  Future<ApiResult<SigninEntity>> signin(SigninPostModel postModel);
}
