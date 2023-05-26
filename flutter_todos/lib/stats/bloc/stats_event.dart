import 'package:equatable/equatable.dart';

class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object?> get props => [];
}

class StatsSubscriptionRequest extends StatsEvent {
  const StatsSubscriptionRequest();
}
