import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/data/datasources/signin_local_data_source_contract.dart';
import 'package:super_fitness_app/features/signin/data/datasources/signin_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';
import 'package:super_fitness_app/features/signin/data/models/response/user.dart';
import 'package:super_fitness_app/features/signin/data/repositories/signin_repository_impl.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';

class MockSigninLocalDataSource extends Mock
    implements SigninLocalDataSourceContract {}

class MockSigninRemoteDataSource extends Mock
    implements SigninRemoteDataSourceContract {}

void main() {
  late MockSigninLocalDataSource mockSigninLocalDataSource;
  late MockSigninRemoteDataSource mockSigninRemoteDataSource;
  late SigninRepositoryImpl repository;

  var postModel = SigninPostModel(
    email: 'jane.doe@example.com',
    password: 'Secret123',
  );

  setUp(() {
    mockSigninLocalDataSource = MockSigninLocalDataSource();
    mockSigninRemoteDataSource = MockSigninRemoteDataSource();
    repository = SigninRepositoryImpl(
      signinLocalDataSource: mockSigninLocalDataSource,
      signinRemoteDataSourceContract: mockSigninRemoteDataSource,
    );
  });

  group('SigninRepositoryImpl.signin', () {
    test(
      'returns a success result, maps the response to entity, and caches the token',
      () async {
        final response = SigninResponse(
          message: 'Success',
          token: 'token-123',
          user: User(id: 'user-1', firstName: 'Jane', lastName: 'Doe'),
        );

        when(() => mockSigninRemoteDataSource.signin(postModel)).thenAnswer(
          (_) async => SuccessApiResult<SigninResponse>(data: response),
        );
        when(
          () => mockSigninLocalDataSource.cachedToken('token-123'),
        ).thenAnswer((_) async {});

        final result = await repository.signin(postModel);

        expect(result, isA<SuccessApiResult<SigninEntity>>());

        final successResult = result as SuccessApiResult<SigninEntity>;
        expect(successResult.data.id, 'user-1');
        expect(successResult.data.firstName, 'Jane');
        expect(successResult.data.lastName, 'Doe');

        verifyInOrder([
          () => mockSigninRemoteDataSource.signin(postModel),
          () => mockSigninLocalDataSource.cachedToken('token-123'),
        ]);
        verifyNoMoreInteractions(mockSigninRemoteDataSource);
        verifyNoMoreInteractions(mockSigninLocalDataSource);
      },
    );

    test(
      'caches an empty token string when the response token is null',
      () async {
        final response = SigninResponse(
          message: 'Success',
          token: null,
          user: User(id: 'user-2', firstName: 'John', lastName: 'Smith'),
        );

        when(() => mockSigninRemoteDataSource.signin(postModel)).thenAnswer(
          (_) async => SuccessApiResult<SigninResponse>(data: response),
        );
        when(
          () => mockSigninLocalDataSource.cachedToken(''),
        ).thenAnswer((_) async {});

        final result = await repository.signin(postModel);

        expect(result, isA<SuccessApiResult<SigninEntity>>());

        final successResult = result as SuccessApiResult<SigninEntity>;
        expect(successResult.data.id, 'user-2');
        expect(successResult.data.firstName, 'John');
        expect(successResult.data.lastName, 'Smith');

        verify(() => mockSigninRemoteDataSource.signin(postModel)).called(1);
        verify(() => mockSigninLocalDataSource.cachedToken('')).called(1);
        verifyNoMoreInteractions(mockSigninRemoteDataSource);
        verifyNoMoreInteractions(mockSigninLocalDataSource);
      },
    );

    test(
      'returns entity with empty strings when the response user data is missing',
      () async {
        final response = SigninResponse(
          message: 'Success',
          token: 'token-456',
          user: null,
        );

        when(() => mockSigninRemoteDataSource.signin(postModel)).thenAnswer(
          (_) async => SuccessApiResult<SigninResponse>(data: response),
        );
        when(
          () => mockSigninLocalDataSource.cachedToken('token-456'),
        ).thenAnswer((_) async {});

        final result = await repository.signin(postModel);

        expect(result, isA<SuccessApiResult<SigninEntity>>());

        final successResult = result as SuccessApiResult<SigninEntity>;
        expect(successResult.data.id, isEmpty);
        expect(successResult.data.firstName, isEmpty);
        expect(successResult.data.lastName, isEmpty);

        verify(() => mockSigninRemoteDataSource.signin(postModel)).called(1);
        verify(
          () => mockSigninLocalDataSource.cachedToken('token-456'),
        ).called(1);
        verifyNoMoreInteractions(mockSigninRemoteDataSource);
        verifyNoMoreInteractions(mockSigninLocalDataSource);
      },
    );

    test(
      'returns an error result and does not cache a token when remote signin fails',
      () async {
        when(() => mockSigninRemoteDataSource.signin(postModel)).thenAnswer(
          (_) async => ErrorApiResult<SigninResponse>(
            error: 'Invalid email or password',
          ),
        );

        final result = await repository.signin(postModel);

        expect(result, isA<ErrorApiResult<SigninEntity>>());

        final errorResult = result as ErrorApiResult<SigninEntity>;
        expect(errorResult.error, 'Invalid email or password');

        verify(() => mockSigninRemoteDataSource.signin(postModel)).called(1);
        verifyNever(() => mockSigninLocalDataSource.cachedToken(any()));
        verifyNoMoreInteractions(mockSigninRemoteDataSource);
        verifyZeroInteractions(mockSigninLocalDataSource);
      },
    );

    test('rethrows when the remote data source throws an exception', () async {
      final exception = Exception('network down');

      when(
        () => mockSigninRemoteDataSource.signin(postModel),
      ).thenThrow(exception);

      expect(() => repository.signin(postModel), throwsA(same(exception)));

      verify(() => mockSigninRemoteDataSource.signin(postModel)).called(1);
      verifyNever(() => mockSigninLocalDataSource.cachedToken(any()));
      verifyNoMoreInteractions(mockSigninRemoteDataSource);
      verifyZeroInteractions(mockSigninLocalDataSource);
    });
  });
}
