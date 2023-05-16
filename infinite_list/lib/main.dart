import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_list/posts/post_bloc_observer.dart';

import 'app.dart';

void main() {
  Bloc.observer = PostBlocObserver();
  runApp( App());
}
