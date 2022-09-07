import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/modules/create_stories/stories_widgets/menu_bitton.dart';

import '../../shared/components/colors_style.dart';
import '../../shared/components/icon_broken.dart';
import '../create_post/widgets/video_post.dart';
import '../home/home_widgets/post_layout_video.dart';

class CreateStoriesScreen extends StatelessWidget {
  CreateStoriesScreen({Key? key}) : super(key: key);
  TextEditingController storyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Story'),
            actions: [
              IconButton(
                onPressed: () {
                  if(cubit.storyVideo!=null||cubit.storyImage!=null){
                    cubit.uploadAndCreateStory(
                      storyText: storyController.text,
                      storyDateTime: DateTime.now().toString(),
                    );
                  }else{
                    cubit.createStory(
                      storyText: storyController.text,
                      storyDateTime: DateTime.now().toString(),
                    );
                  }
                  cubit.storyImage=null;
                  cubit.storyVideo=null;
                  storyController.clear();
                },
                icon: const Icon(IconBroken.Send),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: StoryMenuBottom(
                  cubit: cubit,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, left: 8, bottom: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cubit.storyImage != null)
                    Container(
                      width: 500,
                      height: 350,
                      margin: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(cubit.storyImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                  if (cubit.storyVideo != null)
                    SizedBox(
                      width: 600,
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VideoItem(video: cubit.storyVideo),
                      ),
                    ),
                  TextFormField(
                    controller: storyController,
                    maxLines: null,
                    cursorColor: defaultColor,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 25, fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                        filled: false,
                        hintText: 'Write Your Story',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 25)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
