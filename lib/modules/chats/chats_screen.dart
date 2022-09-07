import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/modules/chats/widgets/user_chat_item.dart';
import 'package:social_app1/shared/components/colors_style.dart';

import '../../shared/card_loading/card_loading.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        List<UserModel> users = cubit.users.where((element) => element.uId != cubit.userModel!.uId).toList();
        if (cubit.users.isEmpty) {
          return const ExampleCardLoading();
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chats",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontFamily: 'SeaSandSun', fontSize: 70),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return UserItem(model: users[index],);
                      },
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                        height: 10,
                      ),
                      itemCount: users.length,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
