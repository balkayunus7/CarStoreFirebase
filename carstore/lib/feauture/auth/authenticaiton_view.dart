import 'package:carstore/feauture/auth/authenticaiton_provider.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class AuthenticaitonView extends ConsumerStatefulWidget {
  const AuthenticaitonView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticaitonViewState();
}

class _AuthenticaitonViewState extends ConsumerState<AuthenticaitonView> {
  // provider for authentication
  final authProvider =
      StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });

  @override
  void initState() {
    super.initState();
    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUserDetail(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
        actions: [
          firebase.AuthStateChangeAction<firebase.SignedIn>((context, state) {
            if (state.user != null) {
              checkUser(state.user);
            }
          }),
        ],
        child: SafeArea(
          child: Padding(
            padding: context.padding.low,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _header(),
                  Padding(
                    padding: context.padding.normal,
                    child: firebase.LoginView(
                      showTitle: false,
                      action: firebase.AuthAction.signIn,
                      providers: firebase.FirebaseUIAuth.providersFor(
                        FirebaseAuth.instance.app,
                      ),
                    ),
                  ),
                  if (ref.watch(authProvider).isRedirect)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        StringConstants.continiueApp,
                        textAlign: TextAlign.center,
                        style: context.general.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _header extends StatelessWidget {
  const _header({
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: context.padding.onlyBottomLow,
          child: Text(
            StringConstants.login,
            style: context.general.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          StringConstants.welcomeBack,
          style: context.general.textTheme.titleMedium,
        ),
      ],
    );
  }
}
