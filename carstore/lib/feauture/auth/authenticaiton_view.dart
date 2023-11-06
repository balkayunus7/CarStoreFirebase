import 'package:carstore/feauture/auth/authenticaiton_provider.dart';
import 'package:carstore/feauture/home/navigation_menu.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_constants.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
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
        child: SingleChildScrollView(
          child: Padding(
            padding: context.padding.low.copyWith(top: 180),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _Header(),
                  const _FirebaseAuth(),
                  if (ref.watch(authProvider).isRedirect)
                    TextButton(
                      onPressed: () {
                        context.route.navigateToPage(const NavigationMenu());
                      },
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

class _FirebaseAuth extends StatelessWidget {
  const _FirebaseAuth();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: firebase.LoginView(
        showTitle: false,
        action: firebase.AuthAction.signIn,
        providers: firebase.FirebaseUIAuth.providersFor(
          FirebaseAuth.instance.app,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: context.padding.onlyBottomNormal,
          child: ClipRRect(
              borderRadius: context.border.lowBorderRadius,
              child: IconConstants.playstore.toImage),
        ),
        Padding(
          padding: context.padding.onlyBottomLow,
          child: const TitleText(
            title: StringConstants.login,
            color: ColorConstants.primaryOrange,
          ),
        ),
        const SubtitleText(
          subtitle: StringConstants.welcomeBack,
          color: ColorConstants.primaryGrey,
        ),
      ],
    );
  }
}
