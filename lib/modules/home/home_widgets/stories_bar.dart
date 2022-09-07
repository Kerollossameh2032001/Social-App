import 'package:flutter/material.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/modules/create_stories/create_stories_screen.dart';
import 'package:social_app1/modules/create_stories/stories_widgets/story_page.dart';
import 'package:social_app1/shared/components/widgets.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/colors_style.dart';

class StoriesBar extends StatelessWidget {
  final List<UserModel> users;

  const StoriesBar({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> uIds= List.generate(LayoutCubit.get(context).stories.length, (index) => LayoutCubit.get(context).stories[index].uId);
    List<UserModel> hasStoryUser = users.where((element) => uIds.contains(element.uId)).toList();
    print("Hase Story ${hasStoryUser[0].name}");
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: FloatingActionButton(
                  onPressed: () {
                    navigateTo(context, CreateStoriesScreen());
                  },
                  backgroundColor: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                      side: const BorderSide(color: defaultColor, width: 2)),
                  child: const Icon(
                    Icons.add,
                    color: defaultColor,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 18),
              ...hasStoryUser
                  .map((element) =>
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              navigateTo(context, StoryPage(users: hasStoryUser,initialPage: hasStoryUser.indexOf(element),));
                            },
                            backgroundColor:
                            Theme
                                .of(context)
                                .scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                                side: const BorderSide(
                                    color: defaultColor, width: 2)),
                            child: CircleAvatar(
                              backgroundColor: defaultColor,
                              radius: 30,
                              backgroundImage: NetworkImage(element.image),
                            ),
                          ),
                          Text(
                            element.name,
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
