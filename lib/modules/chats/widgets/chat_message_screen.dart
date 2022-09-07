import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/notification_data.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/shared/card_loading/card_loading.dart';
import 'package:social_app1/shared/components/colors_style.dart';
import 'package:social_app1/shared/dio_helper/dio_helper.dart';
import '../../../shared/components/icon_broken.dart';
import '../../create_post/widgets/document_item.dart';
import '../../create_post/widgets/video_post.dart';
import 'build_message.dart';
import 'build_my_message.dart';
import 'chats_menu_button.dart';

class ChatMessageScreen extends StatelessWidget {
  final UserModel model;
  TextEditingController messageController = TextEditingController();

  ChatMessageScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit.get(context).getMessage(receiverId: model.uId);
    return Builder(
      builder: (context) {
        return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LayoutCubit cubit = LayoutCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: defaultColor,
                      backgroundImage: NetworkImage(model.image),
                    ),
                    const SizedBox(width: 10),
                    Text(model.name,
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
                leading: IconButton(
                    onPressed: () {
                      cubit.chatVideo = null;
                      cubit.chatImage = null;
                      cubit.chatDocument = null;
                      messageController.clear();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              body: state
                      is LayoutGetMessageLoadingState //cubit.messages.isEmpty
                  ? const ExampleCardLoading()
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (cubit.userModel!.uId ==
                                    cubit.messages[index].senderId) {
                                  return BuildMyMessage(
                                      message: cubit.messages[index]);
                                } else {
                                  return BuildMessage(
                                      message: cubit.messages[index]);
                                }
                              },
                              separatorBuilder: (context, state) =>
                                  const SizedBox(height: 10),
                              itemCount: cubit.messages.length,
                            ),
                          ),
                          if (cubit.chatImage != null)
                            Container(
                              width: 300,
                              height: 200,
                              margin: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(cubit.chatImage!),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          if (cubit.chatVideo != null)
                            SizedBox(
                              width: 300,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: VideoItem(video: cubit.chatVideo),
                              ),
                            ),
                          if (cubit.chatDocument != null)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DocumentItem(
                                  details: cubit.chatDocumentDetails,
                                  document: cubit.chatDocument!),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    maxLines: null,
                                    cursorColor: defaultColor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(IconBroken.Send),
                                          onPressed: () {
                                            if (cubit.chatVideo != null ||
                                                cubit.chatImage != null ||
                                                cubit.chatDocument != null) {
                                              cubit.upLoadAndSendMessage(
                                                  receiverId: model.uId,
                                                  message:
                                                      messageController.text,
                                                  dateTime: DateTime.now()
                                                      .toString());
                                            } else {
                                              cubit.sendMessage(
                                                receiverId: model.uId,
                                                dateTime:
                                                    DateTime.now().toString(),
                                                message: messageController.text,
                                              );
                                            }
                                            cubit.chatVideo = null;
                                            cubit.chatImage = null;
                                            cubit.chatDocument = null;
                                            messageController.clear();
                                            cubit.sendApiNotification(token: model.token);
                                          }),
                                      hintText: 'Message',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                    ),
                                  ),
                                ),
                                ChatsMenuButton(cubit: cubit),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
