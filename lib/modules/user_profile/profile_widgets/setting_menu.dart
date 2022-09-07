import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app1/modules/edit_profile/edit_profile_screen.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/cache_helper/cache_helper.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';
import '../../../shared/components/widgets.dart';
import '../../login/Login_Screen.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: defaultColor,
      buttonSize: Size(40, 40),
      animatedIcon: AnimatedIcons.list_view,
      overlayOpacity: 0.2,
      direction: SpeedDialDirection.down,
      spaceBetweenChildren: 8,
      children: [
        SpeedDialChild(
          child: const Icon(IconBroken.Edit),
          onTap: () {
            navigateTo(context, EditProfileScreen());
          },
          label: "Edit profile",
        ),
        SpeedDialChild(
          child: const Icon(Icons.brightness_2_outlined),
          onTap: () {
            cubit.changeTheme();
          },
          label: "Change Theme",
        ),
        SpeedDialChild(
          child: const Icon(IconBroken.Logout),
          onTap: () async{
            CacheHelper.removeData(key: 'uId').then((value) async {
              if (value) {
                await FirebaseMessaging.instance.deleteToken().then((value){
                  navigateAndReplacement(context, LoginScreen());
                  cubit.currentIndex = 0;
                  GoogleSignIn().signOut();
                });
              }
            });
          },
          label: "Sign Out",
        ),
      ],
    );
  }
}