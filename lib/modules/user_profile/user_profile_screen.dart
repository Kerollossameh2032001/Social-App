import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app1/models/post_model.dart';
import 'package:social_app1/modules/user_profile/profile_widgets/addStory_and_Edit_bottuns.dart';
import 'package:social_app1/modules/user_profile/profile_widgets/profile_and_cover_image.dart';
import 'package:social_app1/modules/user_profile/profile_widgets/setting_menu.dart';
import 'package:social_app1/modules/user_profile/profile_widgets/user_account_status.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/cache_helper/cache_helper.dart';
import '../../shared/components/colors_style.dart';
import '../../shared/components/icon_broken.dart';
import '../../shared/components/widgets.dart';
import '../home/home_widgets/post_item.dart';
import '../login/Login_Screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        List<PostModel> userPosts = cubit.posts
            .where((element) => element.uId == cubit.userModel!.uId)
            .toList();
        return SingleChildScrollView(
          child: Column(
            children: [
              ProfileAndCoverImages(cubit: cubit),
              const SizedBox(height: 60),
              Text(
                cubit.userModel!.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cubit.userModel!.bio,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 15,
                      ),
                ),
              ),
              UserAccountStatus(postsCount: userPosts.length),
              const SizedBox(height: 30),
              const AddStoryAndEditButtons(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 20),
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Activity,
                      color: Theme.of(context).textTheme.headline6!.color,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Recent Posts',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
              if(userPosts.isNotEmpty)
                 Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>PostItem(model: userPosts[index],index: index),
                  separatorBuilder: (context,index)=>const SizedBox(height: 5,),
                  itemCount: userPosts.length,
                ),
              ),
              if(userPosts.isEmpty)
                const SizedBox(height: 30),
              if(userPosts.isEmpty)
                Text('There is no posts yet', style: Theme.of(context).textTheme.headline6,)
            ],
          ),
        );
      },
    );
  }
}
