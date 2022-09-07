import 'package:flutter/material.dart';

import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';
import '../../../shared/components/widgets.dart';
import '../../create_stories/create_stories_screen.dart';
import '../../edit_profile/edit_profile_screen.dart';

class AddStoryAndEditButtons extends StatelessWidget {
  const AddStoryAndEditButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                navigateTo(context, CreateStoriesScreen());
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(defaultColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                    ),
                    child: const Icon(
                      Icons.add,
                      color: defaultColor,
                      size: 15,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Add Story',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            onPressed: () {
              navigateTo(context, EditProfileScreen());
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
                minimumSize: MaterialStateProperty.all(Size(125, 36)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
            child: Row(
              children: const [
                Icon(IconBroken.Edit),
                SizedBox(width: 10),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
