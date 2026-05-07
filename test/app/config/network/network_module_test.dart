import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/config/network/interceptor.dart';
import 'package:super_fitness_app/app/core/values/app_endpoint_strings.dart';

class MockAuthStorage extends Mock implements AuthStorage {}

void main() {
  late MockAuthStorage mockAuthStorage;

  setUp(() {
    mockAuthStorage = MockAuthStorage();
    when(() => mockAuthStorage.getToken()).thenAnswer((_) async => null);
  });

  group('NetworkModule — Dio configuration', () {
    Dio _buildDio() {
      final dio = Dio(
        BaseOptions(
          baseUrl: AppEndpoints.baseUrl,
          headers: {'Content-Type': 'application/json'},
        ),
      );
      dio.interceptors.add(AppInterceptor(mockAuthStorage));
      return dio;
    }

    test('Dio baseUrl is set to AppEndpoints.baseUrl', () {
      final dio = _buildDio();
      expect(dio.options.baseUrl, AppEndpoints.baseUrl);
    });

    test('Dio baseUrl ends with a forward slash (valid API base)', () {
      expect(AppEndpoints.baseUrl.endsWith('/'), isTrue);
    });

    test('Dio Content-Type header is application/json', () {
      final dio = _buildDio();
      expect(dio.options.headers['Content-Type'], 'application/json');
    });

    test('Dio interceptors list contains AppInterceptor', () {
      final dio = _buildDio();
      final hasAppInterceptor = dio.interceptors.any(
        (i) => i is AppInterceptor,
      );
      expect(hasAppInterceptor, isTrue);
    });

    test('Dio interceptors list is not empty', () {
      final dio = _buildDio();
      expect(dio.interceptors, isNotEmpty);
    });
  });

  group('AppEndpoints', () {
    test('baseUrl is a valid HTTPS URL', () {
      expect(AppEndpoints.baseUrl.startsWith('https://'), isTrue);
    });

    test('all endpoint paths are non-empty strings', () {
      final endpoints = [
        AppEndpoints.signInPath,
        AppEndpoints.signupPath,
        AppEndpoints.profilePath,
        AppEndpoints.logoutPath,
        AppEndpoints.randomMusclesPath,
        AppEndpoints.levelsPath,
        AppEndpoints.exercisesPath,
        AppEndpoints.editProfilePath,
        AppEndpoints.uploadProfileImagePath,
        AppEndpoints.getLoggedUserDataPath,
        AppEndpoints.exercisesByMuscleDifficulty,
      ];
      for (final path in endpoints) {
        expect(path.isNotEmpty, isTrue, reason: '$path must not be empty');
      }
    });

    test(
      'getLoggedUserDataPath and profilePath point to the same endpoint',
      () {
        expect(AppEndpoints.getLoggedUserDataPath, AppEndpoints.profilePath);
      },
    );

    test('randomMusclesPath and musclesRandomPath are equivalent', () {
      expect(AppEndpoints.randomMusclesPath, AppEndpoints.musclesRandomPath);
    });
  });
}
