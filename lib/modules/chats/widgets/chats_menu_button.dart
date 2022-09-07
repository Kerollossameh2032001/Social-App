import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';

class ChatsMenuButton extends StatelessWidget {
  const ChatsMenuButton({
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
              cubit.chatImage = null;
              cubit.chatVideo = null;
              cubit.chatDocument = null;
              cubit.pickChatImage(source: ImageSource.gallery);
            },
            label: "Add photo",
          ),
          SpeedDialChild(
              child: const Icon(IconBroken.Camera),
              onTap: () {
                cubit.chatImage = null;
                cubit.chatVideo = null;
                cubit.chatDocument = null;
                cubit.pickChatImage(source: ImageSource.camera);
              },
              label: "Take photo"
          ),
          SpeedDialChild(
              child: const Icon(IconBroken.Video),
              onTap: () {
                cubit.chatImage = null;
                cubit.chatVideo = null;
                cubit.chatDocument = null;
                cubit.pickChatVideo(source: ImageSource.gallery);
              },
              label: "Add Video"
          ),
          SpeedDialChild(
              child: const Icon(Icons.video_camera_back),
              onTap: () {
                cubit.chatImage = null;
                cubit.chatVideo = null;
                cubit.chatDocument = null;
                cubit.pickChatVideo(source: ImageSource.camera);
              },
              label: "Take Video"
          ),
          SpeedDialChild(
              child: const Icon(IconBroken.Paper_Upload),
              onTap: () {
                cubit.chatImage = null;
                cubit.chatVideo = null;
                cubit.chatDocument = null;
                cubit.pickChatDocument();
              },
              label: "Add Document"
          ),
        ],
      ),
    );
  }
}