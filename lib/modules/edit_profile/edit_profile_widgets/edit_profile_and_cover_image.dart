import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app1/layout/cubit/cubit.dart';

import '../../../models/user_model.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';

class EditProfileAndCoverImages extends StatelessWidget {
  final UserModel model;

  const EditProfileAndCoverImages({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: LayoutCubit.get(context).userCoverImage== null?
                      DecorationImage(
                        image: NetworkImage(model.coverImage),
                        fit: BoxFit.cover,
                      ):
                      DecorationImage(
                        image: FileImage(LayoutCubit.get(context).userCoverImage!),
                        fit: BoxFit.cover,
                      ),
                      gradient: defaultGradient,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50))),
                ),
                Positioned(
                  left: 310,
                  top: 40,
                  child: SpeedDial(
                    icon: IconBroken.Camera,
                    backgroundColor: defaultColor,
                    buttonSize: Size(40,40),
                    overlayOpacity: 0.2,
                    direction: SpeedDialDirection.down,
                    children: [
                      SpeedDialChild(
                        label: 'Take photo',
                        child: Icon(Icons.add_a_photo),
                        onTap: (){
                          LayoutCubit.get(context).pickUserCoverImage(source: ImageSource.camera);
                        }
                      ),
                      SpeedDialChild(
                        label: 'Add photo',
                        child: Icon(IconBroken.Image),
                        onTap: (){
                          LayoutCubit.get(context).pickUserCoverImage(source: ImageSource.gallery);
                        }
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 30,
              right: 310,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 125,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: defaultColor,
                    child: LayoutCubit.get(context).userImage== null?
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(model.image),
                    ):
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(LayoutCubit.get(context).userImage!),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0,left: 60),
          child: SpeedDial(
            icon: IconBroken.Camera,
            backgroundColor: defaultColor,
            buttonSize: Size(40,40),
            overlayOpacity: 0.2,
            direction: SpeedDialDirection.down,
            children: [
              SpeedDialChild(
                  label: 'Take photo',
                  child: Icon(Icons.add_a_photo),
                  onTap: (){
                    LayoutCubit.get(context).pickUserImage(source: ImageSource.camera);
                  }
              ),
              SpeedDialChild(
                  label: 'Add photo',
                  child: Icon(IconBroken.Image),
                  onTap: (){
                    LayoutCubit.get(context).pickUserImage(source: ImageSource.gallery);
                  }
              )
            ],
          ),
        ),
      ],
    );
  }
}
