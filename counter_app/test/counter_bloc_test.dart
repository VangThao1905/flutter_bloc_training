import 'package:counter_app/counter_bloc/counter_bloc.dart';
import 'package:counter_app/counter_bloc/counter_event.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    test('initial state is 0', () {
      expect(counterBloc.state, 0);
    });

    blocTest('emits [1] CounterIncrementPressed',
        build: () => counterBloc,
        act: (bloc) => bloc.add(CounterIncrementPressed()),
        expect: () => [1]);

    blocTest('emits [-1] CounterDecrementPressed',
        build: () => counterBloc,
        act: (bloc) => bloc.add(CounterDecrementPressed()),
        expect: () => [-1]);
  });
}
