import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app1/models/message_model.dart';

import '../../home/home_widgets/post_document_item.dart';
import '../../home/home_widgets/post_layout_video.dart';

class BuildMyMessage extends StatelessWidget {
  final MessageModel message;
  const BuildMyMessage({
    Key? key, required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 5),
        decoration: const BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (message.messageImage != '')
              Container(
                width: 200,
                height: 150,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(message.messageImage),
                      fit: BoxFit.cover,
                    )),
              ),
            if (message.messageDocument != '')
              Container(
                  width: 270,
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PostDocItem(
                      src: message.messageDocument,
                      name: message.messageDocumentName,
                      size: message.messageDocumentSize)),
            if (message.messageVideo != '')
              SizedBox(
                  width: 150,
                  height: 150,
                  child: PostVideoLayout(videoUrl: message.messageVideo)),
            Text(
              message.message,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white,fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SizedBox(
                width: 50,
                child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Text(
                    DateFormat.jm().format(DateTime.parse(message.dateTime)),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white,fontSize: 10,height: 0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
