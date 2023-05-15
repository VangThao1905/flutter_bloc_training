import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/timer/bloc/timer_bloc.dart';
import 'package:flutter_timer/timer/bloc/timer_event.dart';

import 'bloc/timer_state.dart';

class MyActions extends StatelessWidget {
  const MyActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (state is TimerInitial) ...[
            FloatingActionButton(
              onPressed: () {
                context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration));
              },
              child: const Icon(Icons.play_arrow),
            )
          ],
          if (state is TimerRunInProgress) ...[
            FloatingActionButton(
              onPressed: () {
                context.read<TimerBloc>().add(TimerPaused());
              },
              child: const Icon(Icons.pause),
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<TimerBloc>().add(TimerReset());
              },
              child: const Icon(Icons.replay),
            )
          ],
          if (state is TimerRunPause) ...[
            FloatingActionButton(
              onPressed: () {
                context.read<TimerBloc>().add(TimerResumed());
              },
              child: const Icon(Icons.play_arrow),
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<TimerBloc>().add(TimerReset());
              },
              child: const Icon(Icons.replay),
            )
          ],
          if (state is TimerRunComplete) ...[
            FloatingActionButton(
              onPressed: () {
                context.read<TimerBloc>().add(TimerReset());
              },
              child: const Icon(Icons.replay),
            ),
          ]
        ],
      );
    });
  }
}
