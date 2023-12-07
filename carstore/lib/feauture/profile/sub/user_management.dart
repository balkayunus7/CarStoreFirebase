import 'package:carstore/feauture/profile/profile_provider.dart';
import 'package:carstore/product/constants/color_constants.dart';
import 'package:carstore/product/constants/string_constants.dart';
import 'package:carstore/product/widget/app_bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

// * State notifier provider created to be used in the profile page
final _profilProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});



class UserManagementPage extends ConsumerStatefulWidget {
  const UserManagementPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends ConsumerState<UserManagementPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(_profilProvider.notifier).GetCurrentUser());
  }


  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(_profilProvider).currentUser;
  if (currentUser != null) {
    return Scaffold(
      appBar: CustomAppBar(
        'User Management',
        iconColor: ColorConstants.primaryDark,
        onPressed: () {
        context.route.pop();
        },
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: const SizedBox.shrink(),
      ),
      body: Column(
        children: [
          CircleAvatar(
                  radius: 50,
                  backgroundImage: Image.network(currentUser.profilePhoto ?? '')
                      .image,
                ),
           Center(
            child: TextButton(
              onPressed: () {},
              child: Text(StringConstants.userManagementTitle,
                          style: context.general.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold,color: ColorConstants.primaryTextButton)),
            ),
          ),

          Padding(
            padding: context.padding.horizontalNormal,
            child: _CustomStatTextfield(labelText:'Name' ,),
          ),
          Padding(
            padding: context.padding.horizontalNormal,
            child: _CustomStatTextfield(labelText:'Username' ,),
          ),
          Padding(
            padding: context.padding.horizontalNormal,
            child: _CustomStatTextfield(labelText: 'Biyografi',),
          ),
        ],
      )
    );
  }
  else {
      return SizedBox.shrink();
    }
 }
}

class _CustomStatTextfield extends StatelessWidget {
  const _CustomStatTextfield({required this.labelText} );

  final String labelText ;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: labelText + ' :',
        labelStyle: context.general.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600,color: ColorConstants.primaryGrey),
       
    ),
              );
  }
}