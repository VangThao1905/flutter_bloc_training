import 'package:bloc/bloc.dart';
import 'package:counter_cubit/app.dart';
import 'package:counter_cubit/counter_observer.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(CounterApp());
}
