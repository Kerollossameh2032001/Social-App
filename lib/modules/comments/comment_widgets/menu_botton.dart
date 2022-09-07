import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SpeedDial(
        buttonSize: const Size(40, 40),
        elevation: 0.0,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: defaultColor,
        overlayOpacity: 0.2,
        children: [
          SpeedDialChild(
            child: const Icon(IconBroken.Image),
            onTap: () {
              cubit.commentImage = null;
              cubit.commentVideo = null;
              cubit.commentDocument = null;
              cubit.pickCommentImage(source: ImageSource.gallery);
            },
            label: "Add photo",
          ),
          SpeedDialChild(
              child: const Icon(IconBroken.Camera),
              onTap: () {
                cubit.commentImage = null;
                cubit.commentVideo = null;
                cubit.commentDocument = null;
                cubit.pickCommentImage(source: ImageSource.camera);
              },
              label: "Take photo"
          ),
          SpeedDialChild(
              child: const Icon(IconBroken.Video),
              onTap: () {
                cubit.commentImage = null;
                cubit.commentVideo = null;
                cubit.commentDocument = null;
                cubit.pickCommentVideo(source: ImageSource.gallery);
              },
              label: "Add Video"
          ),
          SpeedDialChild(
              child: const Icon(Icons.video_camera_back),
              onTap: () {
                cubit.commentImage = null;
                cubit.commentVideo = null;
                cubit.commentDocument = null;
                cubit.pickCommentVideo(source: ImageSource.camera);
              },
              label: "Take Video"
          ),
          SpeedDialChild(
              child: const Icon(IconBroken.Paper_Upload),
              onTap: () {
                cubit.commentImage = null;
                cubit.commentVideo = null;
                cubit.commentDocument = null;
                cubit.pickCommentDocument();
              },
              label: "Add Document"
          ),
        ],
      ),
    );
  }
}