import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'home_widgets/page_header.dart';
import 'home_widgets/post_item.dart';
import 'home_widgets/stories_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context ,state){},
      builder: (context ,state){
        LayoutCubit cubit = LayoutCubit.get(context);

        //cubit.getUserData();
        return Padding(
          padding: const EdgeInsets.only(top: 55.0, left: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(model: cubit.userModel!,),
                StoriesBar(users: cubit.users),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) => PostItem(model: cubit.posts[index],index: index),
                  separatorBuilder: (context,index)=> const SizedBox(height: 5),
                  itemCount: cubit.posts.length,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
