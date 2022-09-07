import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/post_model.dart';
import 'package:social_app1/modules/comments/comments_screen.dart';
import 'package:social_app1/modules/home/home_widgets/post_document_item.dart';
import 'package:social_app1/modules/home/home_widgets/post_layout_video.dart';
import 'package:social_app1/shared/components/widgets.dart';
import '../../../shared/components/colors_style.dart';
import '../../../shared/components/icon_broken.dart';

class PostItem extends StatefulWidget {
  final PostModel model;
  final int index;

  PostItem({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool check = false;
  MaterialColor color = Colors.grey;

  @override
  void initState() {
    try {
      setState(() {
        check = LayoutCubit.get(context).likesData!.like;
        print(LayoutCubit.get(context).likesData!.like);
        color = check? Colors.red : Colors.grey;
      });
    } catch (error) {
      setState(() {
        check = false;
        color = Colors.grey;
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    check = false;
    color = Colors.grey;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LayoutCubit cubit = LayoutCubit.get(context);
            return Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                right: 15.0,
              ),
              child: Card(
                color: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: defaultColor,
                            backgroundImage: NetworkImage(widget.model.image),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.model.name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                DateFormat.jm().format(DateTime.parse(widget.model.dateTime)),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_horiz))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(widget.model.text),
                    ),
                    if (widget.model.postImage != '')
                      Container(
                        width: 300,
                        height: 250,
                        margin: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(widget.model.postImage),
                              fit: BoxFit.cover,
                            )),
                      ),
                    if (widget.model.postDocument != '')
                      PostDocItem(
                          src: widget.model.postDocument,
                          name: widget.model.postDocumentName!,
                          size: widget.model.postDocumentSize!),
                    if (widget.model.postVideo != '')
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:
                            PostVideoLayout(videoUrl: widget.model.postVideo),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                cubit.createLikes(
                                    postId: cubit.postsId[widget.index],
                                    status: !check);
                                print("Before ${cubit.likesData!.like}");
                                try {
                                  setState(() {
                                    check = !check;
                                    color = check ? Colors.red : Colors.grey;
                                  });
                                } catch (error) {
                                  setState(() {
                                    check = false;
                                    color = Colors.grey;
                                  });
                                }
                                //cubit.getPostsData();
                                print('the cjhe smoascj : $check');
                              },
                              child: Icon(
                                IconBroken.Heart,
                                color: color,
                              )),
                          const SizedBox(width: 5),
                          Text(
                            '${check? cubit.likesNumber[widget.index] + 1: cubit.likesNumber[widget.index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(width: 18),
                          InkWell(
                            onTap: (){
                              navigateTo(context, CommentsScreen(postId: cubit.postsId[widget.index],));
                            },
                            child: Row(
                              children: [
                                const Icon(IconBroken.Chat),
                                const SizedBox(width: 5),
                                Text(
                                  '${cubit.commentNumber[widget.index]}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: InkWell(
                                onTap: () {
                                  navigateTo(context, CommentsScreen(postId: cubit.postsId[widget.index]));
                                },
                                child: const Icon(IconBroken.Send)),
                          )
                        ],
                      ),
                    )
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
