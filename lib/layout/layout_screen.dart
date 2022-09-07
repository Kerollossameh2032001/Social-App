import 'package:badges/badges.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/modules/create_post/create_post_screen.dart';
import 'package:social_app1/shared/components/colors_style.dart';
import 'package:social_app1/shared/components/constant.dart';
import 'package:social_app1/shared/components/widgets.dart';
import '../shared/card_loading/card_loading.dart';
import '../shared/components/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit.get(context).getUserStories();
    LayoutCubit.get(context).getUsersData();
    LayoutCubit.get(context).getUserData();
    LayoutCubit.get(context).getPostsData();
    LayoutCubit.get(context).notificationsOnMessage();
    LayoutCubit.get(context).notificationsOnMessageOpenedApp();
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          body: cubit.userModel == null ||
                  cubit.posts.isEmpty ||
                  cubit.users.isEmpty || cubit.stories.isEmpty
              ? const ExampleCardLoading()
              : cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            elevation: 50,
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: IconButton(
                    onPressed: () {
                      cubit.changeButtonNav(0);
                    },
                    icon: Icon(IconBroken.Home),
                    color: cubit.currentIndex == 0 ? defaultColor : Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: IconButton(
                      onPressed: () {
                        cubit.changeButtonNav(1);
                      },
                      icon: Badge(
                        badgeContent: Text(
                          '$count',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        badgeColor: defaultColor,
                        animationType: BadgeAnimationType.scale,
                        showBadge: count == 0 ? false : true,
                        child: Icon(
                          IconBroken.Notification,
                          color: cubit.currentIndex == 1
                              ? defaultColor
                              : Colors.grey,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90.0),
                  child: IconButton(
                      onPressed: () {
                        cubit.changeButtonNav(2);
                      },
                      icon: Icon(
                        IconBroken.Chat,
                        color: cubit.currentIndex == 2
                            ? defaultColor
                            : Colors.grey,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: IconButton(
                      onPressed: () {
                        cubit.changeButtonNav(3);
                      },
                      icon: Icon(
                        Icons.person_outline,
                        color: cubit.currentIndex == 3
                            ? defaultColor
                            : Colors.grey,
                      )),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            onPressed: () {
              //navigateTo(context, CreatePostScreen());
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreatePostScreen()));
            },
            child: Container(
              child: Icon(Icons.add),
            ),
            backgroundColor: defaultColor,
          ),
        );
      },
    );
  }
}
