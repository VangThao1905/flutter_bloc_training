import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_basic/counter_state.dart';

import 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0)) {
    on<IncrementEvent>((event, emit) => emit(CounterState(counter: state.counter+1)));
    on<DecrementEvent>((event, emit) => emit(CounterState(counter: state.counter-1)));
  }

  // void onIncrement() {
  //   add(IncrementEvent());
  // }
  //
  // void onDecrement() {
  //   add(DecrementEvent());
  // }

  @override
  CounterState get initialState => CounterState.initial();

  @override
  Stream<CounterState> mapEventToState(CounterState state,
      CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield state..counter += 1;
    } else if (event is DecrementEvent) {
      yield state..counter -= 1;
    }
  }
}
