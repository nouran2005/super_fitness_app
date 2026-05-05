import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';
import 'package:super_fitness_app/features/signin/domain/repositories/signin_repository.dart';
import 'package:super_fitness_app/features/signin/domain/use_cases/signin_use_case.dart';

import 'signin_use_case_test.mocks.dart';

@GenerateMocks([SigninRepository])
void main() {
  late MockSigninRepository mockRepository;
  late SigninUseCase useCase;

  setUpAll(() {
    provideDummy<ApiResult<SigninEntity>>(
      SuccessApiResult<SigninEntity>(
        data: SigninEntity(id: '1', firstName: 'Ahmed', lastName: 'Ali'),
      ),
    );
  });

  setUp(() {
    mockRepository = MockSigninRepository();
    useCase = SigninUseCase(signinRepository: mockRepository);
  });

  test('should call repository.signin and return success result', () async {
    final model = SigninPostModel(email: 'test@mail.com', password: '123456');

    final entity = SigninEntity(id: '1', firstName: 'Ahmed', lastName: 'Ali');

    when(
      mockRepository.signin(model),
    ).thenAnswer((_) async => SuccessApiResult<SigninEntity>(data: entity));

    // Act
    final result = await useCase.execute(model);

    // Assert
    expect(result, isA<SuccessApiResult<SigninEntity>>());

    final success = result as SuccessApiResult<SigninEntity>;
    expect(success.data.id, '1');
    expect(success.data.firstName, 'Ahmed');
    expect(success.data.lastName, 'Ali');

    verify(mockRepository.signin(model)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return error when repository fails', () async {
    final model = SigninPostModel(email: 'test@mail.com', password: '123456');

    when(
      mockRepository.signin(model),
    ).thenAnswer((_) async => ErrorApiResult(error: 'login failed'));

    // Act
    final result = await useCase.execute(model);

    // Assert
    expect(result, isA<ErrorApiResult>());

    final error = result as ErrorApiResult;
    expect(error.error, 'login failed');

    verify(mockRepository.signin(model)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
