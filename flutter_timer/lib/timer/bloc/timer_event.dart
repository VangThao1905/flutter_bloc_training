abstract class TimerEvent {
  TimerEvent();
}

class TimerStarted extends TimerEvent {
  TimerStarted({required this.duration});

  final int duration;
}

class TimerPaused extends TimerEvent {
  TimerPaused();
}

class TimerResumed extends TimerEvent {
  TimerResumed();
}

class TimerReset extends TimerEvent {
  TimerReset();
}

class TimerTicked extends TimerEvent {
  TimerTicked({required this.duration});

  final int duration;
}
