import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/app/app.dart';
import 'package:flutter_firebase_login/app/bloc/app_state.dart';
import 'package:flutter_firebase_login/home/view/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../sign_up/view/sign_up_page.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ));
          }
        },
        child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 76,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 16,
                ),
                _EmailInput(),
                const SizedBox(
                  height: 8,
                ),
                _PasswordInput(),
                const SizedBox(
                  height: 8,
                ),
                _LoginButton(),
                const SizedBox(
                  height: 8,
                ),
                _GoogleLoginButton(),
                const SizedBox(
                  height: 8,
                ),
                _SignUpButton()
              ],
            ))));
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'email',
                helperText: '',
                errorText:
                    state.email.displayError != null ? 'invalid email' : null),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().passwordChanged(email),
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'password',
                helperText: '',
                errorText: state.password.displayError != null
                    ? 'invalid password'
                    : null),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
              key: const Key('loginForm_continue_raisedButton'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: const Color(0xFFFFD600)),
              onPressed: state.isValid
                  ? () {
                      context.read<LoginCubit>().logInWithCredentials();
                    }
                  : null,
              child: const Text('Login'));
    });
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      onPressed: () {
        context.read<LoginCubit>().loginWithGoogle();
      },
      icon: const Icon(
        FontAwesomeIcons.google,
        color: Colors.white,
      ),
      label: const Text(
        'sign in with google',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: theme.colorScheme.secondary),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child:
          Text('create account', style: TextStyle(color: theme.primaryColor)),
    );
  }
}
