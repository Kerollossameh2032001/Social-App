import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/shared/components/colors_style.dart';

import '../../shared/components/constant.dart';
import 'notification_widgets/notification_Item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        LayoutCubit cubit = LayoutCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(
            top: 45.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                ),
                child: Text(
                  "Notifications",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontFamily: 'SeaSandSun', fontSize: 70),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => BuildNotificationItem(model: currentNotifications[index]),
                  separatorBuilder: (context, index)=>const Divider(height: 40),
                  itemCount: currentNotifications.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
