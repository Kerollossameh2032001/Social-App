import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/modules/create_post/widgets/bottom_sheet.dart';
import 'package:social_app1/modules/create_post/widgets/custom_bottom_app_bar.dart';
import 'package:social_app1/modules/create_post/widgets/document_item.dart';
import 'package:social_app1/modules/create_post/widgets/video_post.dart';
import 'package:social_app1/modules/home/home_screen.dart';
import 'package:social_app1/shared/components/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../shared/components/colors_style.dart';
import '../../shared/components/icon_broken.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Share Post'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    if (cubit.postVideo != null ||
                        cubit.postImage != null ||
                        cubit.document != null) {
                      cubit.uploadAndCreate(
                          text: postController.text,
                          dateTime: DateTime.now().toString());
                    } else {
                      cubit.createPost(
                          text: postController.text,
                          dateTime: DateTime.now().toString());
                    }
                    cubit.postVideo = null;
                    cubit.postImage = null;
                    cubit.document = null;

                  },
                  child: Text(
                    'Post',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: defaultColor,
                        ),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: defaultColor,
                        backgroundImage: NetworkImage(cubit.userModel!.image),
                      ),
                      const SizedBox(width: 18),
                      Text(
                        cubit.userModel!.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: postController,
                    maxLines: null,
                    cursorColor: defaultColor,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What \'s in your mind...?!',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  if (cubit.postImage != null)
                    Container(
                      width: 400,
                      height: 350,
                      margin: const EdgeInsets.only(
                          top: 30, left: 8, right: 8, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(cubit.postImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                  const SizedBox(height: 15.0),
                  if (cubit.postVideo != null)
                    VideoItem(
                      video: cubit.postVideo,
                    ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (cubit.document != null) DocumentItem(details: cubit.documentDetails,document: cubit.document!),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomAppBar(cubit: cubit),
        );
      },
    );
  }
}
