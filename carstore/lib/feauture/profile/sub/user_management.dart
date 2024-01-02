import 'dart:io';

import 'package:carstore/feauture/profile/providers/profile_provider.dart';
import 'package:carstore/feauture/profile/profile_view.dart';
import 'package:carstore/feauture/profile/providers/theme_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/widget/app_bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

// * State notifier provider created to be used in the profile page
final profilProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

class UserManagementPage extends ConsumerStatefulWidget {
  const UserManagementPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserManagementPageState();
}

class _UserManagementPageState extends ConsumerState<UserManagementPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(profilProvider.notifier).getCurrentUser());
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(profilProvider).currentUser;
    final appTheme = ref.watch(appThemeStateNotifier);

    if (currentUser != null) {
      return Scaffold(
          appBar: CustomAppBar(
            StringConstants.userManagementTitle,
            iconColor: appTheme.isDarkModeEnabled
                ? ColorConstants.primaryWhite
                : ColorConstants.primaryDark,
            onPressed: () {
              context.route.pop();
            },
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: const SizedBox.shrink(),
          ),
          body: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(
                  File(currentUser.profilePhoto ?? ''),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    ref.watch(profilProvider.notifier).pickImage();
                  },
                  child: Text(StringConstants.userManagementButton,
                      style: context.general.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: appTheme.isDarkModeEnabled
                              ? ColorConstants.primaryWhite
                              : ColorConstants.primaryTextButton)),
                ),
              ),
              Padding(
                padding: context.padding.normal,
                child: _CustomStatTextfield(
                  labelText: StringConstants.userManagementName,
                  onPressed: () {},
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: context.padding.normal,
                child: _CustomStatTextfield(
                  labelText: StringConstants.userManagementBio,
                  onPressed: () {},
                  controller: _bioController,
                ),
              ),
              Padding(
                padding: context.padding.onlyTopNormal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: context.padding.horizontalNormal,
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .watch(profilProvider.notifier)
                              .changeUsername(
                                  _nameController.text, _bioController.text)
                              .then((value) => context.route
                                  .navigateToPage(const ProfileView()));
                        },
                        child: Text(StringConstants.userManagementEdit,
                            style: context.general.textTheme.bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: appTheme.isDarkModeEnabled
                                        ? ColorConstants.primaryWhite
                                        : ColorConstants.primaryTextButton)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _CustomStatTextfield extends ConsumerWidget {
  const _CustomStatTextfield(
      {required this.labelText,
      required this.onPressed,
      required this.controller});

  final String labelText;
  final VoidCallback onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: '$labelText :',
        labelStyle: context.general.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w600,
          color: ref.watch(appThemeStateNotifier).isDarkModeEnabled == false
              ? ColorConstants.primaryDark
              : ColorConstants.primaryWhite,
        ),
      ),
    );
  }
}
