import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';

class StoryMenuBottom extends StatelessWidget {
  const StoryMenuBottom({
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
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,//defaultColor,
        overlayOpacity: 0.2,
        direction: SpeedDialDirection.down,
        animatedIconTheme: IconThemeData(size: 30,color: Theme.of(context).appBarTheme.iconTheme!.color),
        children: [
          SpeedDialChild(
            child: const Icon(IconBroken.Image),
            onTap: () {
              cubit.storyImage = null;
              cubit.storyVideo = null;
              cubit.pickStoryImage(source: ImageSource.gallery);},
            label: "Add photo",
          ),
          SpeedDialChild(
              child: const Icon(IconBroken.Camera),
              onTap: () {
                cubit.storyImage = null;
                cubit.storyVideo = null;
                cubit.pickStoryImage(source: ImageSource.camera);},
              label: "Take photo"
          ),
        ],
      ),
    );
  }
}