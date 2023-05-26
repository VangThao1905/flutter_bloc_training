import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/bloc/app_event.dart';
import 'package:flutter_firebase_login/home/widgets/avatar.dart';

import '../../app/bloc/app_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              key: const Key('homePage_logout_iconButton'),
              onPressed: () {
                context.read<AppBloc>().add(AppLogoutRequested());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          children: [
            Avatar(photo: user.photo),
            const SizedBox(
              height: 4,
            ),
            Text(
              user.email ?? '',
              style: textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              user.name ?? '',
              style: textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
