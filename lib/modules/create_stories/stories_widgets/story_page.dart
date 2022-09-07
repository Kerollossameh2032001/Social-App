import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/shared/card_loading/card_loading.dart';
import 'package:story/story_page_view/story_page_view.dart';
import '../../../models/story_model.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';
import '../../chats/widgets/chats_menu_button.dart';
import '../../create_post/widgets/document_item.dart';
import '../../create_post/widgets/video_post.dart';
import '../../home/home_widgets/post_layout_video.dart';

class StoryPage extends StatefulWidget {
  final List<UserModel> users;
  final int initialPage;

  StoryPage({Key? key, required this.users, required this.initialPage})
      : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        LayoutCubit.get(context).getUserStories();
        return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LayoutCubit cubit = LayoutCubit.get(context);

            return Scaffold(
              body: cubit.stories.isEmpty
                  ? ExampleCardLoading()
                  : StoryPageView(
                      initialPage: widget.initialPage,
                      itemBuilder: (context, pageIndex, storyIndex) {
                        UserModel user = widget.users[pageIndex];
                        List<StoryModel> stories = cubit.stories
                            .where((element) => element.uId == user.uId)
                            .toList();
                        if (stories.isEmpty) Navigator.pop(context);
                        StoryModel story = stories[storyIndex];
                        //final storyUserModel user = sampleUsers[pageIndex];
                        //final StoryModel story = user.stories[storyIndex];
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                            if (story.storyImage != '')
                              Positioned.fill(
                                child: Image.network(
                                  //story.imageUrl,
                                  story.storyImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Center(
                                child: Text(
                              story.storyText,
                              style: Theme.of(context).textTheme.headline6!,
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 44, left: 8),
                              child: Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        //image: NetworkImage(user.imageUrl),
                                        image: NetworkImage(user.image),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    //user.userName,
                                    user.name,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      gestureItemBuilder: (context, pageIndex, storyIndex) {
                        return Stack(children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                color: Colors.white,
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 650,
                            left: 150,
                            child: InkWell(
                              onTap: () async {
                                indicatorAnimationController.value =
                                    IndicatorAnimationCommand.pause;
                                await showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                      //Spacer(),
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
                                                              receiverId: widget.users[pageIndex].uId,
                                                              message: messageController.text,
                                                              dateTime:
                                                              DateTime.now().toString());
                                                        } else {
                                                          cubit.sendMessage(
                                                            receiverId: widget.users[pageIndex].uId,
                                                            dateTime:
                                                            DateTime.now().toString(),
                                                            message: messageController.text,
                                                          );
                                                        }
                                                        cubit.chatVideo = null;
                                                        cubit.chatImage = null;
                                                        cubit.chatDocument = null;
                                                        messageController.clear();
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
                                );
                                indicatorAnimationController.value =
                                    IndicatorAnimationCommand.resume;
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.keyboard_double_arrow_up),
                                  Text(
                                    'Replay',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                            ),
                          ),

                          /*  if (pageIndex == 0)
                          Center(
                            child: ElevatedButton(
                              child: Text('show modal bottom sheet'),
                              onPressed: () async {
                                indicatorAnimationController.value =
                                    IndicatorAnimationCommand.pause;
                                await showModalBottomSheet(
                                  context: context,
                                  builder: (context) => SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(24),
                                      child: Text(
                                        'Look! The indicator is now paused\n\n'
                                        'It will be coutinued after closing the modal bottom sheet.',
                                        style:
                                            Theme.of(context).textTheme.headline5,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                                indicatorAnimationController.value =
                                    IndicatorAnimationCommand.resume;
                              },
                            ),
                          ),*/
                        ]);
                      },
                      indicatorAnimationController:
                          indicatorAnimationController,
                      initialStoryIndex: (pageIndex) {
                        if (pageIndex == 0) {
                          return 1;
                        }
                        return 0;
                      },
                      //pageLength: sampleUsers.length,
                      pageLength: widget.users.length,
                      storyLength: (int pageIndex) {
                        //return sampleUsers[pageIndex].stories.length;
                        return cubit.stories
                            .where((element) =>
                                element.uId == widget.users[pageIndex].uId)
                            .toList()
                            .length;
                      },
                      onPageLimitReached: () {
                        Navigator.pop(context);
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
