import 'package:carstore/feauture/auth/login_view.dart';
import 'package:carstore/feauture/auth/provider/auth_pod.dart';
import 'package:carstore/feauture/auth/sub_view.dart/custom_textform.dart';
import 'package:carstore/feauture/item/selected_item_view.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/enums/image_constants.dart';
import 'package:carstore/product/enums/widget_sizes.dart';
import 'package:carstore/product/widget/text/subtitle_text.dart';
import 'package:carstore/product/widget/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

// Define RegisterPage class which extends ConsumerWidget
class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  // Define text editing controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Override build method
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get auth notifier from provider
    final authNotifer = ref.watch(authProvider);
    // Return Scaffold widget
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: context.padding.low
              .copyWith(top: WidgetSize.paddingAuthTop.value),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header widget
                const _Header(),
                // Name input field
                Padding(
                    padding: context.padding.normal,
                    child: CustomTextfield(
                      controller: _nameController,
                      hintText: StringConstants.hintName,
                      iconFirst: Icons.person,
                    )),
                // Email input field
                Padding(
                    padding: context.padding.normal,
                    child: CustomTextfield(
                        controller: _emailController,
                        hintText: StringConstants.hintTextEmail,
                        iconFirst: Icons.email)),
                // Password input field
                Padding(
                    padding: context.padding.normal,
                    child: CustomTextfieldPassword(
                        controller: _passwordController,
                        hintText: StringConstants.hintTextPassword,
                        iconFirst: Icons.lock)),
                // Register button
                BuyButton(
                    onPressed: () {
                      // Sign up user with Firebase
                      authNotifer
                          .signUpUserWithFirebase(_emailController.text,
                              _passwordController.text, _nameController.text)
                          // ignore: body_might_complete_normally_catch_error
                          .catchError((e) {
                        authNotifer.errorMessage(
                            context, e, 'Register is Failed! ${e.toString()}');
                      }).then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage())));
                    },
                    iconText: StringConstants.register),
                // Link to login page
                Padding(
                    padding: context.padding.normal,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(StringConstants.routingTextRegister,
                          style: context.general.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Define _Header class which extends StatelessWidget
class _Header extends StatelessWidget {
  // Constructor
  const _Header();

  // Override build method
  @override
  Widget build(BuildContext context) {
    // Return Column widget
    return Column(
      children: [
        // Spacing
        SizedBox(height: WidgetSize.sizedBoxNormal.value),
        // Logo
        Padding(
          padding: context.padding.onlyBottomNormal,
          child: ClipRRect(
              borderRadius: context.border.lowBorderRadius,
              child: IconConstants.playstore.toImage),
        ),
        // Title
        Padding(
          padding: context.padding.onlyBottomLow,
          child: const TitleText(
            title: StringConstants.register,
            color: ColorConstants.primaryOrange,
          ),
        ),
        // Subtitle
        const SubtitleText(
          subtitle: StringConstants.welcomeBack,
          color: ColorConstants.primaryGrey,
        ),
      ],
    );
  }
}
