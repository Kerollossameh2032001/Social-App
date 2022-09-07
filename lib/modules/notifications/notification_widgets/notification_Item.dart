import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/notification_model.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/shared/components/widgets.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/colors_style.dart';
import '../../chats/widgets/chat_message_screen.dart';

class BuildNotificationItem extends StatelessWidget {
  final NotificationModel model;
  const BuildNotificationItem({
    Key? key, required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        LayoutCubit cubit = LayoutCubit.get(context);
        UserModel senderNotificationModel = cubit.users.firstWhere((element) => element.uId == model.uId);
        return ListTile(
          onTap: (){
            navigateTo(context, ChatMessageScreen(model: senderNotificationModel));
          },
          title: Text(senderNotificationModel.name,style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18,height: 2),),
          subtitle: Text(model.body),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: defaultColor,
            backgroundImage: NetworkImage(senderNotificationModel.image),
          ),
          trailing: Column(
            children: [
              Icon(Icons.arrow_forward_ios,color: Theme.of(context).appBarTheme.iconTheme!.color,),
              Spacer(),
              //DateFormat.jm().format(DateTime.parse(widget.model.dateTime)
              Text(DateFormat.jm().format(DateTime.parse(model.dateTime)), style: Theme.of(context).textTheme.caption,)

            ],
          ),
        );
      },
    );
  }
}