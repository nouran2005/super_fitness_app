import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/config/network/interceptor.dart';

class MockAuthStorage extends Mock implements AuthStorage {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class _FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late MockAuthStorage mockAuthStorage;
  late AppInterceptor interceptor;

  setUpAll(() {
    registerFallbackValue(_FakeRequestOptions());
  });

  setUp(() {
    mockAuthStorage = MockAuthStorage();
    interceptor = AppInterceptor(mockAuthStorage);
  });

  RequestOptions _buildOptions(String url) =>
      RequestOptions(path: url, baseUrl: '');

  group('AppInterceptor', () {
    test('is an Interceptor', () {
      expect(interceptor, isA<Interceptor>());
    });

    test(
      'adds Authorization header when token exists and URL is not Firebase',
      () async {
        // arrange
        const token = 'my_valid_token';
        final options = _buildOptions('https://api.example.com/endpoint');
        final handler = MockRequestInterceptorHandler();

        when(() => mockAuthStorage.getToken()).thenAnswer((_) async => token);
        when(() => handler.next(any())).thenReturn(null);

        // act — onRequest returns void, not a Future
        interceptor.onRequest(options, handler);
        // wait for the internal async call (getToken) to complete
        await Future<void>.delayed(Duration.zero);

        // assert
        expect(options.headers['Authorization'], 'Bearer $token');
        verify(() => handler.next(options)).called(1);
      },
    );

    test(
      'does NOT add Authorization header for Firebase URLs (googleapis.com)',
      () async {
        // arrange
        const token = 'my_valid_token';
        final options = _buildOptions(
          'https://storage.googleapis.com/bucket/file',
        );
        final handler = MockRequestInterceptorHandler();

        when(() => mockAuthStorage.getToken()).thenAnswer((_) async => token);
        when(() => handler.next(any())).thenReturn(null);

        // act
        interceptor.onRequest(options, handler);
        await Future<void>.delayed(Duration.zero);

        // assert
        expect(options.headers.containsKey('Authorization'), isFalse);
        verify(() => handler.next(options)).called(1);
      },
    );

    test('does NOT add Authorization header when token is null', () async {
      // arrange
      final options = _buildOptions('https://api.example.com/endpoint');
      final handler = MockRequestInterceptorHandler();

      when(() => mockAuthStorage.getToken()).thenAnswer((_) async => null);
      when(() => handler.next(any())).thenReturn(null);

      // act
      interceptor.onRequest(options, handler);
      await Future<void>.delayed(Duration.zero);

      // assert
      expect(options.headers.containsKey('Authorization'), isFalse);
      verify(() => handler.next(options)).called(1);
    });

    test(
      'does NOT add Authorization header when token is empty string',
      () async {
        // arrange
        final options = _buildOptions('https://api.example.com/endpoint');
        final handler = MockRequestInterceptorHandler();

        when(() => mockAuthStorage.getToken()).thenAnswer((_) async => '');
        when(() => handler.next(any())).thenReturn(null);

        // act
        interceptor.onRequest(options, handler);
        await Future<void>.delayed(Duration.zero);

        // assert
        expect(options.headers.containsKey('Authorization'), isFalse);
        verify(() => handler.next(options)).called(1);
      },
    );

    test('always calls handler.next regardless of token state', () async {
      // arrange
      final options = _buildOptions('https://api.example.com/endpoint');
      final handler = MockRequestInterceptorHandler();

      when(() => mockAuthStorage.getToken()).thenAnswer((_) async => null);
      when(() => handler.next(any())).thenReturn(null);

      // act
      interceptor.onRequest(options, handler);
      await Future<void>.delayed(Duration.zero);

      // assert
      verify(() => handler.next(any())).called(1);
    });
  });
}
