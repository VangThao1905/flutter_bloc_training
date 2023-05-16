import 'package:bloc_login/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_login/authentication/bloc/authentication_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              final userId = context
                  .select((AuthenticationBloc bloc) => bloc.state.user.id);
              return Text('UserID:$userId');
            }),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
