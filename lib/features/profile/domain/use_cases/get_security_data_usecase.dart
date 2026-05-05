import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetSecurityDataUsecase {
  final ProfileRepository _repo;
  GetSecurityDataUsecase(this._repo);

  Future<String> call() {
    return _repo.securityData();
  }
}
