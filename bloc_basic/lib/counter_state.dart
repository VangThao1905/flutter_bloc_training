class CounterState {
  int counter;

  CounterState({required this.counter});

  factory CounterState.initial() => CounterState(counter: 0);
}
