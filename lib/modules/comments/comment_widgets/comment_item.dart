import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/models/comments_model.dart';

import '../../home/home_widgets/post_document_item.dart';
import '../../home/home_widgets/post_layout_video.dart';

class CommentItem extends StatelessWidget {
  final CommentModel model;
  final LayoutCubit cubit;

  const CommentItem({
    Key? key,
    required this.model,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(model.image),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 270,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      model.comment,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              //const SizedBox(height: 5.0),
              if (model.commentImage != '')
                Container(
                  width: 200,
                  height: 150,
                  margin: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(model.commentImage),
                        fit: BoxFit.cover,
                      )),
                ),
              if (model.commentDocument != '')
                Container(
                    width: 270,
                    height: 70,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: PostDocItem(
                        src: model.commentDocument,
                        name: model.commentDocumentName,
                        size: model.commentDocumentSize)),
              if (model.commentVideo != '')
                SizedBox(
                    width: 200,
                    height: 150,
                    child: PostVideoLayout(videoUrl: model.commentVideo)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.jm().format(DateTime.parse(model.dateTime)),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      'Like',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      'Replay',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
