import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetPrivacyPolicyDataUsecase {
  final ProfileRepository _repo;
  GetPrivacyPolicyDataUsecase(this._repo);

  Future<String> call() {
    return _repo.privacyData();
  }
}
