import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/comments_model.dart';
import 'package:social_app1/models/likes_model.dart';
import 'package:social_app1/models/message_model.dart';
import 'package:social_app1/models/story_model.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/modules/chats/chats_screen.dart';
import 'package:social_app1/modules/home/home_screen.dart';
import 'package:social_app1/modules/notifications/notification_screen.dart';
import 'package:social_app1/modules/user_profile/user_profile_screen.dart';
import 'package:social_app1/shared/cache_helper/cache_helper.dart';
import 'package:social_app1/shared/components/constant.dart';

import '../../models/notification_data.dart';
import '../../models/notification_model.dart';
import '../../models/post_model.dart';
import '../../shared/dio_helper/dio_helper.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const NotificationScreen(),
    const ChatsScreen(),
    const UserProfileScreen(),
  ];

  void notificationsOnMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      NotificationModel model = NotificationModel(
        uId: event.data["uId"],
        body: event.data["body"],
        dateTime: event.data["dateTime"],
      );
      currentNotifications.add(model);
      count++;
      print('************************************');
      print(event.data["dateTime"]);
      emit(LayoutNotificationOnOpenedAppMessageState());
    });
  }

  void notificationsOnMessage() {
    FirebaseMessaging.onMessage.listen((event) {
      NotificationModel model = NotificationModel(
        uId: event.data["uId"],
        body: event.data["body"],
        dateTime: event.data["dateTime"],
      );
      count++;
      currentNotifications.add(model);
      print(event.data.toString());
      emit(LayoutNotificationOnMessageState());
    });
  }

  void sendApiNotification({required String token}) {
    emit(LayoutApiSendNotificationLoadingState());
    NotificationSenderData data = NotificationSenderData(
      data: Data(
        body: '${userModel!.name} send you a Message',
        uId: userModel!.uId,
        dateTime: DateTime.now().toString(),
      ),
      notification: NotificationData(
        title: 'Chats',
        body: '${userModel!.name} send you a Message',
      ),
      to: token,
    );
    DioHelper.postNotification(data: data.toMap()).then((value) {
      emit(LayoutApiSendNotificationSuccesState());
    }).catchError((error) {
      emit(LayoutApiSendNotificationErrorState());
    });
  }

  void changeButtonNav(int index) {
    if (index == 1) count = 0;
    currentIndex = index;
    emit(LayoutChangeButtonNavState());
  }

  bool isDark = ThemeMode.system == ThemeMode.dark ? true : false;

  void changeTheme() {
    isDark = !isDark;
    CacheHelper.removeData(key: 'isDark').then((value) {
      CacheHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(LayoutChangeAppThemeState());
      });
    });
  }

  var picker = ImagePicker();

  //Files Pickers
  //pick the Post Image
  File? postImage;

  Future<void> pickPostImage({required ImageSource source}) async {
    final pickedFile =
        await picker.pickImage(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(LayoutPickPostImageSuccesState());
    } else {
      emit(LayoutPickPostImageErrorState());
      print('No Image Selected');
    }
  }

  File? postVideo;

  //pick video
  Future<void> pickPostIVideo({required ImageSource source}) async {
    final pickedFile =
        await picker.pickVideo(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(LayoutPickPostVideoSuccesState());
    } else {
      emit(LayoutPickPostVideoErrorState());
      print('No Video Selected');
    }
  }

  File? document;
  PlatformFile? documentDetails;

  //pick File(PDF)
  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      document = File(result.files.single.path!);
      documentDetails = result.files.first;
      emit(LayoutPickDocumentSuccesState());
    } else {
      // User canceled the picker
      print('No document Selected');
      emit(LayoutPickDocumentErrorState());
    }
  }

  //pick comment image
  File? commentImage;

  Future<void> pickCommentImage({required ImageSource source}) async {
    final pickedFile =
        await picker.pickImage(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      commentImage = File(pickedFile.path);
      emit(LayoutPickCommentImageSuccesState());
    } else {
      emit(LayoutPickCommentImageErrorState());
      print('No Image Selected');
    }
  }

  //pick comment video
  File? commentVideo;

  Future<void> pickCommentVideo({required ImageSource source}) async {
    final pickedFile =
        await picker.pickVideo(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      commentVideo = File(pickedFile.path);
      emit(LayoutPickCommentVideoSuccesState());
    } else {
      emit(LayoutPickCommentVideoErrorState());
      print('No Video Selected');
    }
  }

  //pick File(PDF)
  File? commentDocument;
  PlatformFile? commentDocumentDetails;

  Future<void> pickCommentDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      commentDocument = File(result.files.single.path!);
      commentDocumentDetails = result.files.first;
      emit(LayoutPickCommentDocumentSuccesState());
    } else {
      // User canceled the picker
      print('No commentDocument Selected');
      emit(LayoutPickCommentDocumentErrorState());
    }
  }

  //pick chat image
  File? chatImage;

  Future<void> pickChatImage({required ImageSource source}) async {
    final pickedFile =
        await picker.pickImage(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(LayoutPickChatImageSuccesState());
    } else {
      emit(LayoutPickChatImageErrorState());
      print('No Image Selected');
    }
  }

  //pick chat video
  File? chatVideo;

  Future<void> pickChatVideo({required ImageSource source}) async {
    final pickedFile =
        await picker.pickVideo(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      chatVideo = File(pickedFile.path);
      emit(LayoutPickChatVideoSuccesState());
    } else {
      emit(LayoutPickChatVideoErrorState());
      print('No Video Selected');
    }
  }

  //pick File(PDF)
  File? chatDocument;
  PlatformFile? chatDocumentDetails;

  Future<void> pickChatDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      chatDocument = File(result.files.single.path!);
      chatDocumentDetails = result.files.first;
      emit(LayoutPickChatDocumentSuccesState());
    } else {
      // User canceled the picker
      print('No commentDocument Selected');
      emit(LayoutPickChatDocumentErrorState());
    }
  }

  //pick user image
  File? userImage;

  Future<void> pickUserImage({required ImageSource source}) async {
    final pickedFile =
        await picker.pickImage(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      userImage = File(pickedFile.path);
      emit(LayoutPickUserImageSuccesState());
    } else {
      emit(LayoutPickUserImageErrorState());
      print('No Image Selected');
    }
  }

  // pick user cover image
  File? userCoverImage;

  Future<void> pickUserCoverImage({required ImageSource source}) async {
    final pickedFile =
        await picker.pickImage(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      userCoverImage = File(pickedFile.path);
      emit(LayoutPickUserCoverImageSuccesState());
    } else {
      emit(LayoutPickUserCoverImageErrorState());
      print('No Image Selected');
    }
  }

  //pick story image
  File? storyImage;

  Future<void> pickStoryImage({required ImageSource source}) async {
    final pickedFile =
        await picker.pickImage(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      storyImage = File(pickedFile.path);
      emit(LayoutPickStoryImageSuccesState());
    } else {
      emit(LayoutPickStoryImageErrorState());
      print('No Image Selected');
    }
  }

  //pick story video
  File? storyVideo;

  Future<void> pickStoryVideo({required ImageSource source}) async {
    final pickedFile =
        await picker.pickVideo(source: source /*ImageSource.gallery*/);
    if (pickedFile != null) {
      storyVideo = File(pickedFile.path);
      emit(LayoutPickStoryVideoSuccesState());
    } else {
      emit(LayoutPickStoryVideoErrorState());
      print('No Video Selected');
    }
  }

  //*************************************************************************

  //Firebase & get the data
  //get current user Data
  UserModel? userModel;

  void getUserData() {
    emit(LayoutGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(savedUId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print('UserModelData');
      print(userModel!.name);
      print(userModel!.uId);
      emit(LayoutGetUserDataSuccesState());
    }).catchError((error) {
      emit(LayoutGetUserDataErrorState());
    });
    //print(userModel!.stories![0].storyText);
  }

  //get Profile user Data
  UserModel? profileModel;

  void getProfileData({required String uId}) {
    emit(LayoutGetProfileUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      profileModel = UserModel.fromJson(value.data()!);
      emit(LayoutGetProfileUserDataSuccesState());
    }).catchError((error) {
      emit(LayoutGetProfileUserDataErrorState());
    });
  }

  //upload posts with Video or image or document
  void uploadAndCreate({
    required String? text,
    required String dateTime,
  }) {
    emit(LayoutUploadFileLoadingState());
    if (postImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createPost(text: text, dateTime: dateTime, postImage: value);
          emit(LayoutUploadFileSuccesState());
        }).catchError((error) {
          emit(LayoutUploadFileErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadFileErrorState());
      });
    }
    if (postVideo != null) {
      FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postVideo!.path).pathSegments.last}')
          .putFile(postVideo!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createPost(text: text, dateTime: dateTime, postVideo: value);
          emit(LayoutUploadFileSuccesState());
        }).catchError((error) {
          emit(LayoutUploadFileErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadFileErrorState());
      });
    }
    if (document != null) {
      FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(document!.path).pathSegments.last}')
          .putFile(document!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createPost(
            text: text,
            dateTime: dateTime,
            postDocument: value,
            postDocumentName: p0.ref.name,
            postDocumentSize: documentDetails!.size,
          );
          emit(LayoutUploadFileSuccesState());
        }).catchError((error) {
          emit(LayoutUploadFileErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadFileErrorState());
      });
    }
  }

  //Create posts
  void createPost({
    String? text,
    required String dateTime,
    String? postImage,
    String? postVideo,
    String? postDocument,
    String? postDocumentName,
    int? postDocumentSize,
  }) {
    emit(LayoutCreatePostLoadingState());
    PostModel model = PostModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      postImage: postImage ?? '',
      postVideo: postVideo ?? '',
      postDocument: postDocument ?? '',
      postDocumentName: postDocumentName ?? '',
      postDocumentSize: postDocumentSize ?? 0,
      text: text ?? '',
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(LayoutCreatePostSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutCreatePostErrorState());
    });
  }

  //Create and upload comments with files
  void uploadAndCreateComment({
    required String postId,
    required String? comment,
    required String dateTime,
  }) {
    emit(LayoutUploadCommentFileLoadingState());
    if (commentImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('comments/${Uri.file(commentImage!.path).pathSegments.last}')
          .putFile(commentImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createComment(
            postId: postId,
            comment: comment,
            dateTime: dateTime,
            commentImage: value,
          );
          emit(LayoutUploadCommentFileSuccesState());
        }).catchError((error) {
          emit(LayoutUploadCommentFileErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadCommentFileErrorState());
      });
    }
    if (commentVideo != null) {
      FirebaseStorage.instance
          .ref()
          .child('comments/${Uri.file(commentVideo!.path).pathSegments.last}')
          .putFile(commentVideo!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createComment(
            postId: postId,
            dateTime: dateTime,
            comment: comment,
            commentVideo: value,
          );
          emit(LayoutUploadCommentFileSuccesState());
        }).catchError((error) {
          emit(LayoutUploadCommentFileErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadCommentFileErrorState());
      });
    }
    if (commentDocument != null) {
      FirebaseStorage.instance
          .ref()
          .child(
              'comments/${Uri.file(commentDocument!.path).pathSegments.last}')
          .putFile(commentDocument!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createComment(
            postId: postId,
            dateTime: dateTime,
            comment: comment,
            commentDocument: value,
            commentDocumentName: commentDocumentDetails!.name,
            commentDocumentSize: commentDocumentDetails!.size,
          );
          emit(LayoutUploadCommentFileSuccesState());
        }).catchError((error) {
          emit(LayoutUploadCommentFileErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadCommentFileErrorState());
      });
    }
  }

  //Create comment
  void createComment({
    required String postId,
    String? comment,
    required String dateTime,
    String? commentImage,
    String? commentVideo,
    String? commentDocument,
    String? commentDocumentName,
    int? commentDocumentSize,
  }) {
    CommentModel model = CommentModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      comment: comment ?? '',
      dateTime: dateTime,
      commentImage: commentImage ?? '',
      commentVideo: commentVideo ?? '',
      commentDocument: commentDocument ?? '',
      commentDocumentName: commentDocumentName ?? '',
      commentDocumentSize: commentDocumentSize ?? 0,
    );
    emit(LayoutCreateCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      getComments(posId: postId);
      emit(LayoutCreateCommentSuccesState());
    }).catchError((error) {
      emit(LayoutCreateCommentErrorState());
    });
  }

  //get comments
  List<CommentModel> comments = [];

  void getComments({required String posId}) {
    emit(LayoutGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(posId)
        .collection('comments')
        .orderBy('dateTime')
        .get()
        .then((value) {
      comments = [];
      value.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(LayoutGetCommentsSuccesState());
    }).catchError((error) {
      emit(LayoutGetCommentsErrorState());
    });
  }

  //get posts to display it
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likesNumber = [];
  List<int> commentNumber = [];

  void getPostsData() {
    emit(LayoutGetPostsDataLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      posts = [];
      postsId = [];
      event.docs.forEach((element) {
        element.reference.collection('likes').get().then((likeValue) {
          element.reference.collection('comments').get().then((commentValue) {
            likesNumber.add(likeValue.docs.length);
            commentNumber.add(commentValue.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            getLikesData(postId: element.id);
          }).catchError((error) {});
        }).catchError((error) {});
      });
      emit(LayoutGetPostsDataSuccesState());
    });
  }

  //Create likes
  void createLikes({required String postId, required bool status}) {
    LikesModel model = LikesModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      like: status,
      color: status ? 'red' : 'grey',
    );
    emit(LayoutCreatePostLikesLoadingState());
    if (status) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(userModel!.uId)
          .set(model.toMap())
          .then((value) {
        getLikesData(postId: postId);
        emit(LayoutCreatePostLikesSuccesState());
      }).catchError((error) {
        emit(LayoutCreatePostLikesErrorState());
      });
    } else {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(userModel!.uId)
          .delete()
          .then((value) {
        //getLikesData(postId: postId);
        emit(LayoutDeletePostLikesSuccesState());
      }).catchError((error) {
        emit(LayoutDeletePostLikesErrorState());
      });
    }
  }

  //get Likes data
  //List<LikesModel> likesData = [];
  LikesModel? likesData;

  void getLikesData({required String postId}) {
    emit(LayoutGetPostLikesLoadingState());
    //likesData = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .get()
        .then((value) {
      /*value.data().forEach((element) {
        //likesData.add(LikesModel.fromJson(element.data()));

      });*/
      likesData = LikesModel.fromJson(value.data()!);
      emit(LayoutGetPostLikesSuccesState());
    }).catchError((error) {
      emit(LayoutGetPostLikesErrorState());
    });
  }

  void upLoadAndUpdateUserData({
    required String name,
    required String phone,
    required String? bio,
  }) {
    emit(LayoutUploadAndUpdateLoadingState());
    if (userImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(userImage!.path).pathSegments.last}')
          .putFile(userImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          updateUserData(
              name: name,
              phone: phone,
              image: value,
              coverImage: userModel!.coverImage,
              bio: bio);
          emit(LayoutUploadAndUpdateSuccesState());
        }).catchError((error) {
          emit(LayoutUploadAndUpdateErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadAndUpdateErrorState());
      });
    }
    if (userCoverImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(userCoverImage!.path).pathSegments.last}')
          .putFile(userCoverImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          updateUserData(
              name: name,
              phone: phone,
              image: userModel!.image,
              coverImage: value,
              bio: bio);
          emit(LayoutUploadAndUpdateSuccesState());
        }).catchError((error) {
          emit(LayoutUploadAndUpdateErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadAndUpdateErrorState());
      });
    }
  }

  void updateUserData({
    required String name,
    required String phone,
    required String image,
    required String coverImage,
    required String? bio,
  }) {
    UserModel model = UserModel(
        uId: userModel!.uId,
        name: name,
        email: userModel!.email,
        phone: phone,
        image: image,
        coverImage: coverImage,
        bio: bio ?? 'bio..',
        token: userModel!.token);
    emit(LayoutUpdateUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(LayoutUpdateUserDataSuccesState());
    }).catchError((error) {
      emit(LayoutUpdateUserDataErrorState());
    });
  }

  List<UserModel> users = [];

  void getUsersData() {
    emit(LayoutGetUsersDataLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      users = [];
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });

      emit(LayoutGetUsersDataSuccesState());
    }).catchError((error) {
      emit(LayoutGetUsersDataErrorState());
    });
  }

  void upLoadAndSendMessage({
    required String receiverId,
    required String dateTime,
    required String? message,
  }) {
    emit(LayoutUploadAndSendMessageLoadingState());
    if (chatImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('chats/${Uri.file(chatImage!.path).pathSegments.last}')
          .putFile(chatImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          sendMessage(
            receiverId: receiverId,
            dateTime: dateTime,
            message: message,
            messageImage: value,
          );
          emit(LayoutUploadAndSendMessageSuccesState());
        }).catchError((error) {
          emit(LayoutUploadAndSendMessageErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadAndSendMessageErrorState());
      });
    }
    if (chatVideo != null) {
      FirebaseStorage.instance
          .ref()
          .child('chats/${Uri.file(chatVideo!.path).pathSegments.last}')
          .putFile(chatVideo!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          sendMessage(
            receiverId: receiverId,
            dateTime: dateTime,
            message: message,
            messageVideo: value,
          );
          emit(LayoutUploadAndSendMessageSuccesState());
        }).catchError((error) {
          emit(LayoutUploadAndSendMessageErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadAndSendMessageErrorState());
      });
    }
    if (chatDocument != null) {
      FirebaseStorage.instance
          .ref()
          .child('chats/${Uri.file(chatDocument!.path).pathSegments.last}')
          .putFile(chatDocument!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          sendMessage(
            receiverId: receiverId,
            dateTime: dateTime,
            message: message,
            messageDocument: value,
            messageDocumentName: chatDocumentDetails!.name,
            messageDocumentSize: chatDocumentDetails!.size,
          );
          emit(LayoutUploadAndSendMessageSuccesState());
        }).catchError((error) {
          emit(LayoutUploadAndSendMessageErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadAndSendMessageErrorState());
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String? message,
    String? messageImage,
    String? messageVideo,
    String? messageDocument,
    String? messageDocumentName,
    int? messageDocumentSize,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      message: message ?? '',
      messageImage: messageImage ?? '',
      messageVideo: messageVideo ?? '',
      messageDocument: messageDocument ?? '',
      messageDocumentName: messageDocumentName ?? '',
      messageDocumentSize: messageDocumentSize ?? 0,
    );
    emit(LayoutSendMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(LayoutSendMessageSuccesState());
    }).catchError((error) {
      emit(LayoutSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(LayoutSendMessageSuccesState());
    }).catchError((error) {
      emit(LayoutSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  Map<String, List<MessageModel>> receiverMessages = {};

  void getMessage({
    required String receiverId,
  }) {
    emit(LayoutGetMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      receiverMessages = {};
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      receiverMessages.addAll({receiverId: messages});
      emit(LayoutGetMessageSuccesState());
    });
  }

  void createStory({
    required String? storyText,
    required String storyDateTime,
    String? storyImage,
    String? storyVideo,
  }) {
    emit(LayoutCreateStoryLoadingState());
    StoryModel model = StoryModel(
      uId: userModel!.uId,
      storyText: storyText ?? '',
      storyDateTime: storyDateTime,
      storyImage: storyImage ?? '',
      storyVideo: storyVideo ?? '',
    );
    FirebaseFirestore.instance
        .collection('stories')
        .add(model.toMap())
        .then((value) {
      emit(LayoutCreateStorySuccesState());
    }).catchError((error) {
      emit(LayoutCreateStoryErrorState());
    });
  }

  List<StoryModel> stories = [];

  void getUserStories() {
    stories = [];
    emit(LayoutGetStoryLoadingState());
    FirebaseFirestore.instance.collection('stories').get().then((value) {
      value.docs.forEach((element) {
        print("Kero");
        stories.add(StoryModel.fromJson(element.data()));
      });
      emit(LayoutGetStorySuccesState());
    }).catchError((error) {
      emit(LayoutGetStoryErrorState());
    });
  }

  //Create and upload Story with files
  void uploadAndCreateStory({
    required String storyText,
    required String storyDateTime,
  }) {
    emit(LayoutUploadAndCreateStoryLoadingState());
    if (storyImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('stories/${Uri.file(storyImage!.path).pathSegments.last}')
          .putFile(storyImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createStory(
            storyText: storyText,
            storyDateTime: storyDateTime,
            storyImage: value,
          );
          emit(LayoutUploadAndCreateStorySuccesState());
        }).catchError((error) {
          emit(LayoutUploadAndCreateStoryErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadCommentFileErrorState());
      });
    }
    if (storyVideo != null) {
      FirebaseStorage.instance
          .ref()
          .child('stories/${Uri.file(storyVideo!.path).pathSegments.last}')
          .putFile(storyVideo!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          createStory(
            storyText: storyText,
            storyDateTime: storyDateTime,
            storyVideo: value,
          );
          emit(LayoutUploadAndCreateStorySuccesState());
        }).catchError((error) {
          emit(LayoutUploadAndCreateStoryErrorState());
        });
      }).catchError((error) {
        emit(LayoutUploadCommentFileErrorState());
      });
    }
  }
}
