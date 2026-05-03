import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';

void main() {
  group('Resource', () {
    test('initial constructor sets status to initial', () {
      final resource = Resource<String>.initial();
      
      expect(resource.status, Status.initial);
      expect(resource.isInitial, isTrue);
      expect(resource.isLoading, isFalse);
      expect(resource.isSuccess, isFalse);
      expect(resource.isError, isFalse);
      expect(resource.data, isNull);
      expect(resource.error, isNull);
    });

    test('loading constructor sets status to loading', () {
      final resource = Resource<String>.loading();
      
      expect(resource.status, Status.loading);
      expect(resource.isLoading, isTrue);
      expect(resource.data, isNull);
      expect(resource.error, isNull);
    });

    test('success constructor sets status to success and data', () {
      final resource = Resource<String>.success('test_data');
      
      expect(resource.status, Status.success);
      expect(resource.isSuccess, isTrue);
      expect(resource.data, 'test_data');
      expect(resource.error, isNull);
    });

    test('error constructor sets status to error and errorMessage', () {
      final resource = Resource<String>.error('test_error');
      
      expect(resource.status, Status.error);
      expect(resource.isError, isTrue);
      expect(resource.data, isNull);
      expect(resource.error, 'test_error');
    });

    test('props returns correct properties for equatable', () {
      final resource1 = Resource<String>.success('data');
      final resource2 = Resource<String>.success('data');
      final resource3 = Resource<String>.error('error');

      expect(resource1, equals(resource2));
      expect(resource1, isNot(equals(resource3)));
      expect(resource1.props, containsAll([Status.success, 'data', null]));
    });
  });
}
