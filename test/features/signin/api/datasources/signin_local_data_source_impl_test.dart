import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/features/signin/api/datasources/signin_local_data_source_impl.dart';

import 'signin_local_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthStorage])
void main() {
  late MockAuthStorage mockAuthStorage;
  late SigninLocalDataSourceImpl dataSource;

  setUp(() {
    mockAuthStorage = MockAuthStorage();
    dataSource = SigninLocalDataSourceImpl(authStorage: mockAuthStorage);
  });

  test('should call saveToken on AuthStorage with correct token', () async {
    const token = 'test_token';

    await dataSource.cachedToken(token);

    verify(mockAuthStorage.saveToken(token)).called(1);
  });
}
