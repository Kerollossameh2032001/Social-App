import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import '../../shared/components/colors_style.dart';
import '../../shared/components/icon_broken.dart';
import '../create_post/widgets/document_item.dart';
import '../create_post/widgets/video_post.dart';
import 'comment_widgets/comment_item.dart';
import 'comment_widgets/menu_botton.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;

  CommentsScreen({Key? key, required this.postId}) : super(key: key);
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        LayoutCubit.get(context).getComments(posId: postId);
        return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LayoutCubit cubit = LayoutCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("write comments..!"),
              ),
              body: Column(
                children: [
                  if (cubit.comments.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 8.0, left: 5),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => CommentItem(
                            model: cubit.comments[index], cubit: cubit),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 18.0),
                        itemCount: cubit.comments.length,
                      ),
                    ),
                  if (cubit.comments.isEmpty) Spacer(),
                  if (cubit.commentImage != null)
                    Container(
                      width: 300,
                      height: 200,
                      margin: const EdgeInsets.only(
                          top: 5, left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(cubit.commentImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                  if (cubit.commentVideo != null)
                    SizedBox(
                      width: 300,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VideoItem(video: cubit.commentVideo),
                      ),
                    ),
                  if (cubit.commentDocument != null)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DocumentItem(
                          details: cubit.commentDocumentDetails,
                          document: cubit.commentDocument!),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
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
                                    if (cubit.commentVideo != null ||
                                        cubit.commentImage != null ||
                                        cubit.commentDocument != null) {
                                      cubit.uploadAndCreateComment(
                                          postId: postId,
                                          comment: commentController.text,
                                          dateTime: DateTime.now().toString());
                                    } else {
                                      cubit.createComment(
                                        postId: postId,
                                        dateTime: DateTime.now().toString(),
                                        comment: commentController.text,
                                      );
                                    }
                                    cubit.commentVideo = null;
                                    cubit.commentImage = null;
                                    cubit.commentDocument = null;
                                    commentController.clear();
                                  }),
                              hintText: 'Write a comment...!',
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
                        MenuButton(cubit: cubit),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
