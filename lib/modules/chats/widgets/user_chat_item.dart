import 'package:flutter/material.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/models/message_model.dart';
import 'package:social_app1/modules/chats/widgets/chat_message_screen.dart';

import '../../../models/user_model.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/widgets.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Builder(
      //cubit.receiverMessages['receiverId']!.length
      builder: (context) {
        //LayoutCubit.get(context).getMessage(receiverId: model.uId);
        return Padding(
        padding: const EdgeInsets.only(left: 5.0,bottom: 18),
        child: InkWell(
          onTap: (){
            navigateTo(context,ChatMessageScreen(model: model));
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: defaultColor,
                radius: 25,
                backgroundImage: NetworkImage(model.image),
              ),
              const SizedBox(width: 10),
              Text(
                model.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              // Text(
              //   messageModel.message,
              //   style: Theme.of(context).textTheme.caption,
              // ),
            ],
          ),
        ),
      );
      },
    );
  }
}
