import 'package:bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/bloc_observer/bloc_observer.dart';

// A simple Cubit for testing purposes
class _CounterCubit extends Cubit<int> {
  _CounterCubit() : super(0);
  void increment() => emit(state + 1);
}

void main() {
  group('MyBlocObserver', () {
    late MyBlocObserver observer;

    setUp(() {
      observer = MyBlocObserver();
    });

    test('is a BlocObserver', () {
      expect(observer, isA<BlocObserver>());
    });

    test('onCreate is called without throwing', () {
      final cubit = _CounterCubit();
      expect(() => observer.onCreate(cubit), returnsNormally);
      cubit.close();
    });

    test('onChange is called without throwing', () {
      final cubit = _CounterCubit();
      final change = Change<int>(currentState: 0, nextState: 1);
      expect(() => observer.onChange(cubit, change), returnsNormally);
      cubit.close();
    });

    test('onError is called without throwing', () {
      final cubit = _CounterCubit();
      final error = Exception('test error');
      final stackTrace = StackTrace.current;
      expect(() => observer.onError(cubit, error, stackTrace), returnsNormally);
      cubit.close();
    });

    test('onClose is called without throwing', () {
      final cubit = _CounterCubit();
      expect(() => observer.onClose(cubit), returnsNormally);
      cubit.close();
    });
  });
}
