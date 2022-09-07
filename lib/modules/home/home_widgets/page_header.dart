import 'package:flutter/material.dart';
import 'package:social_app1/models/user_model.dart';

import '../../../shared/components/colors_style.dart';

class PageHeader extends StatelessWidget {
  final UserModel model;
  const PageHeader({
    Key? key, required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontFamily: 'SeaSandSun',
                  fontSize: 80,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              'Your Friends recent Posts.',
              style:
              Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
            )
          ],
        ),
        const SizedBox(
          width: 90,
        ),
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children:  [
            CircleAvatar(
              backgroundColor: defaultColor,
              radius: 25,
              backgroundImage: NetworkImage(model.image),
            ),
            const Positioned(
              top: 6,
              right: 3,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        )
      ],
    );
  }
}