import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';
import 'bottom_sheet.dart';

class CustomBottomAppBar extends StatelessWidget {
  final LayoutCubit cubit;

  const CustomBottomAppBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 50,
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 10, bottom: 10.0),
            child: InkWell(
              onTap: () {
                cubit.postImage = null;
                cubit.postVideo = null;
                cubit.document = null;
                cubit.pickPostImage(source: ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(
                    IconBroken.Image,
                    color: defaultColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Add Photo',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10.0),
            child: InkWell(
              onTap: () {
                cubit.postImage = null;
                cubit.postVideo = null;
                cubit.document = null;
                cubit.pickPostIVideo(source: ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(
                    IconBroken.Video,
                    color: defaultColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Add Video',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 10, bottom: 10.0),
            child: InkWell(
              onTap: () {
                buildBottomSheet(context, cubit);
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.more_horiz,
                    color: defaultColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
