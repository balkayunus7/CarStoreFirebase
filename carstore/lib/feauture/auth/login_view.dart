import 'package:carstore/feauture/auth/provider/auth_pod.dart';
import 'package:carstore/feauture/auth/register_view.dart';
import 'package:carstore/feauture/auth/sub_view.dart/custom_textform.dart';
import 'package:carstore/feauture/home/navigation_menu.dart';
import 'package:carstore/feauture/item/selected_item_view.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_constants.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import '../../product/enums/index.dart';
class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifer = ref.watch(authProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: context.padding.low.copyWith(top: WidgetSize.paddingAuthTop.value),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _Header(),
                Padding(
                    padding: context.padding.normal,
                    child: CustomTextfield(
                        controller: _emailController,
                        hintText: StringConstants.hintTextEmail,
                        obscureText: false,
                        icon: Icons.email)),
                Padding(
                    padding: context.padding.normal,
                    child: CustomTextfield(
                        controller: _passwordController,
                        hintText: StringConstants.hintTextPassword,
                        obscureText: true,
                        icon: Icons.lock)),
                BuyButton(
                    onPressed: () {
                      authNotifer
                          .loginUserWithFirebase(
                              // ignore: body_might_complete_normally_catch_error
                              _emailController.text, _passwordController.text).catchError((e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Login is Failed! ${e.toString()}'),
                                  backgroundColor: ColorConstants.primaryRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: WidgetSizeConstants.borderRadiusNormal,
                                  ),
                                  showCloseIcon: true,
                                  onVisible: () {
                                    Future.delayed(const Duration(seconds: 5), () {
                                      ScaffoldMessenger.of(context).clearSnackBars();
                                    });
                                  },
                                  ),
                                );
                              })
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NavigationMenu()))
                                      );
                    },
                    iconText: StringConstants.login),
                Padding(
                    padding: context.padding.normal,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(StringConstants.routingTextLogin,
                          style: context.general.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    )),
              ],
            ),
          ),
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
        SizedBox(height: WidgetSize.sizedBoxNormal.value),
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
