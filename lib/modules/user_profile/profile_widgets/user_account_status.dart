import 'package:flutter/material.dart';

class UserAccountStatus extends StatelessWidget {
  final int postsCount;
  const UserAccountStatus({
    Key? key, required this.postsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0,),
          child: Column(
            children: [
              Text('$postsCount',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 20) ,),
              Text('Posts',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 20) ,),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(top: 12.0,left: 20),
          child: Column(
            children: [
              Text('20K',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 20)),
              Text('Followers',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 20)),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(top: 12.0,left: 20),
          child: Column(
            children: [
              Text('30M',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 20)),
              Text('Following',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 20)),
            ],
          ),
        ),
      ],
    );
  }
}