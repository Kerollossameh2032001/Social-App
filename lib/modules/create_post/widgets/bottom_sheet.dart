import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app1/layout/cubit/cubit.dart';

import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';

void buildBottomSheet(BuildContext context, LayoutCubit cubit) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              cubit.postImage = null;
              cubit.postVideo = null;
              cubit.document = null;
              cubit.pickPostImage(source: ImageSource.gallery);
            },
            child: Row(
              children: [
                const Icon(
                  IconBroken.Image,
                  color: defaultColor,
                ),
                const SizedBox(width: 15),
                Text(
                  'Add Photo',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              cubit.postImage = null;
              cubit.postVideo = null;
              cubit.document = null;
              cubit.pickPostImage(source: ImageSource.camera);
            },
            child: Row(
              children: [
                const Icon(
                  IconBroken.Camera,
                  color: defaultColor,
                ),
                const SizedBox(width: 15),
                Text(
                  'Take Photo',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              cubit.postImage = null;
              cubit.postVideo = null;
              cubit.document = null;
              cubit.pickPostIVideo(source: ImageSource.gallery);
            },
            child: Row(
              children: [
                const Icon(
                  IconBroken.Video,
                  color: defaultColor,
                ),
                const SizedBox(width: 15),
                Text(
                  'Add Video',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              cubit.postImage = null;
              cubit.postVideo = null;
              cubit.document = null;
              cubit.pickPostIVideo(source: ImageSource.camera);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.video_camera_back_rounded,
                  color: defaultColor,
                ),
                const SizedBox(width: 15),
                Text(
                  'Take Video',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              cubit.postImage = null;
              cubit.postVideo = null;
              cubit.pickDocument();
            },
            child: Row(
              children: [
                const Icon(
                  IconBroken.Paper_Upload,
                  color: defaultColor,
                ),
                const SizedBox(width: 15),
                Text(
                  'Up Load Document',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
