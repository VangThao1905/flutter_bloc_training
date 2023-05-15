import 'package:counter_app/counter_bloc/counter_bloc.dart';
import 'package:counter_app/counter_bloc/counter_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Center(
              child: Text(
            '$count',
            style: const TextStyle(fontSize: 24.0),
          ));
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementPressed());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 12,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementPressed());
            },
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
