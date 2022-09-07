import 'package:flutter/material.dart';
import 'package:social_app1/modules/user_profile/profile_widgets/setting_menu.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/colors_style.dart';

class ProfileAndCoverImages extends StatelessWidget {
  const ProfileAndCoverImages({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(cubit.userModel!.coverImage),
                fit: BoxFit.cover,
              ),
              gradient: defaultGradient,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
        ),
        Positioned(
          top: 200,
          child: CircleAvatar(
            radius: 52,
            backgroundColor: defaultColor,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(cubit.userModel!.image),
            ),
          ),
        ),
        const Positioned(
          top: 209,
          left: 210,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: defaultColor,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.green,
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 300,
          child: SettingMenu(cubit: cubit),
        )
      ],
    );
  }
}