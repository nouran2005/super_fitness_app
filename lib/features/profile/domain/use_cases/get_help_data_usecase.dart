import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetHelpDataUsecase {
  final ProfileRepository _repo;
  GetHelpDataUsecase(this._repo);

  Future<String> call() {
    return _repo.helpData();
  }
}
