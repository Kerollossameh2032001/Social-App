abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class LayoutChangeButtonNavState extends LayoutStates {}

class LayoutChangeAppThemeState extends LayoutStates {}

//Notifications

class LayoutNotificationOnMessageState extends LayoutStates {}

class LayoutNotificationOnOpenedAppMessageState extends LayoutStates {}

class LayoutApiSendNotificationLoadingState extends LayoutStates {}

class LayoutApiSendNotificationSuccesState extends LayoutStates {}

class LayoutApiSendNotificationErrorState extends LayoutStates {}

//pickers
//pick posts image
class LayoutPickPostImageSuccesState extends LayoutStates {}

class LayoutPickPostImageErrorState extends LayoutStates {}

//pick posts Video
class LayoutPickPostVideoSuccesState extends LayoutStates {}

class LayoutPickPostVideoErrorState extends LayoutStates {}

//pick posts document
class LayoutPickDocumentSuccesState extends LayoutStates {}

class LayoutPickDocumentErrorState extends LayoutStates {}

//picked comment image
class LayoutPickCommentImageSuccesState extends LayoutStates {}

class LayoutPickCommentImageErrorState extends LayoutStates {}

//pick comment Video
class LayoutPickCommentVideoSuccesState extends LayoutStates {}

class LayoutPickCommentVideoErrorState extends LayoutStates {}

//pick comment document
class LayoutPickCommentDocumentSuccesState extends LayoutStates {}

class LayoutPickCommentDocumentErrorState extends LayoutStates {}

//picked chat image
class LayoutPickChatImageSuccesState extends LayoutStates {}

class LayoutPickChatImageErrorState extends LayoutStates {}

//pick chat Video
class LayoutPickChatVideoSuccesState extends LayoutStates {}

class LayoutPickChatVideoErrorState extends LayoutStates {}

//pick chat document
class LayoutPickChatDocumentSuccesState extends LayoutStates {}

class LayoutPickChatDocumentErrorState extends LayoutStates {}

// pick user image
class LayoutPickUserImageSuccesState extends LayoutStates {}

class LayoutPickUserImageErrorState extends LayoutStates {}

// pick user cover image
class LayoutPickUserCoverImageSuccesState extends LayoutStates {}

class LayoutPickUserCoverImageErrorState extends LayoutStates {}


//picked story image
class LayoutPickStoryImageSuccesState extends LayoutStates {}

class LayoutPickStoryImageErrorState extends LayoutStates {}

//pick story Video
class LayoutPickStoryVideoSuccesState extends LayoutStates {}

class LayoutPickStoryVideoErrorState extends LayoutStates {}


//*****************************************************************************

//firebase
//get User data
class LayoutGetUserDataLoadingState extends LayoutStates {}

class LayoutGetUserDataSuccesState extends LayoutStates {}

class LayoutGetUserDataErrorState extends LayoutStates {}

//get Profile User data
class LayoutGetProfileUserDataLoadingState extends LayoutStates {}

class LayoutGetProfileUserDataSuccesState extends LayoutStates {}

class LayoutGetProfileUserDataErrorState extends LayoutStates {}

//create Post
class LayoutCreatePostLoadingState extends LayoutStates {}

class LayoutCreatePostSuccesState extends LayoutStates {}

class LayoutCreatePostErrorState extends LayoutStates {}

//upload Files to cloud firebase storage

class LayoutUploadFileLoadingState extends LayoutStates {}

class LayoutUploadFileSuccesState extends LayoutStates {}

class LayoutUploadFileErrorState extends LayoutStates {}

//get posts data to display it

class LayoutGetPostsDataLoadingState extends LayoutStates {}

class LayoutGetPostsDataSuccesState extends LayoutStates {}

class LayoutGetPostsDataErrorState extends LayoutStates {}

//Create post Likes
class LayoutCreatePostLikesLoadingState extends LayoutStates {}

class LayoutCreatePostLikesSuccesState extends LayoutStates {}

class LayoutCreatePostLikesErrorState extends LayoutStates {}

class LayoutDeletePostLikesSuccesState extends LayoutStates {}

class LayoutDeletePostLikesErrorState extends LayoutStates {}

//get post Likes
class LayoutGetPostLikesLoadingState extends LayoutStates {}

class LayoutGetPostLikesSuccesState extends LayoutStates {}

class LayoutGetPostLikesErrorState extends LayoutStates {}

//Create comment
class LayoutCreateCommentLoadingState extends LayoutStates {}

class LayoutCreateCommentSuccesState extends LayoutStates {}

class LayoutCreateCommentErrorState extends LayoutStates {}

// upload comment file to cloud fireStore
class LayoutUploadCommentFileLoadingState extends LayoutStates {}

class LayoutUploadCommentFileSuccesState extends LayoutStates {}

class LayoutUploadCommentFileErrorState extends LayoutStates {}

// get comment file to cloud fireStore
class LayoutGetCommentsLoadingState extends LayoutStates {}

class LayoutGetCommentsSuccesState extends LayoutStates {}

class LayoutGetCommentsErrorState extends LayoutStates {}

//update user Data
class LayoutUpdateUserDataLoadingState extends LayoutStates {}

class LayoutUpdateUserDataSuccesState extends LayoutStates {}

class LayoutUpdateUserDataErrorState extends LayoutStates {}

//upload and update user Data
class LayoutUploadAndUpdateLoadingState extends LayoutStates {}

class LayoutUploadAndUpdateSuccesState extends LayoutStates {}

class LayoutUploadAndUpdateErrorState extends LayoutStates {}

//get users data
class LayoutGetUsersDataLoadingState extends LayoutStates {}

class LayoutGetUsersDataSuccesState extends LayoutStates {}

class LayoutGetUsersDataErrorState extends LayoutStates {}

//Create Chats
class LayoutSendMessageLoadingState extends LayoutStates {}

class LayoutSendMessageSuccesState extends LayoutStates {}

class LayoutSendMessageErrorState extends LayoutStates {}

//get message
class LayoutGetMessageLoadingState extends LayoutStates {}

class LayoutGetMessageSuccesState extends LayoutStates {}

class LayoutGetMessageErrorState extends LayoutStates {}

//upload and send message
class LayoutUploadAndSendMessageLoadingState extends LayoutStates {}

class LayoutUploadAndSendMessageSuccesState extends LayoutStates {}

class LayoutUploadAndSendMessageErrorState extends LayoutStates {}

//create story
class LayoutCreateStoryLoadingState extends LayoutStates {}

class LayoutCreateStorySuccesState extends LayoutStates {}

class LayoutCreateStoryErrorState extends LayoutStates {}

//get stories
class LayoutGetStoryLoadingState extends LayoutStates {}

class LayoutGetStorySuccesState extends LayoutStates {}

class LayoutGetStoryErrorState extends LayoutStates {}

//upload and Create story
class LayoutUploadAndCreateStoryLoadingState extends LayoutStates {}

class LayoutUploadAndCreateStorySuccesState extends LayoutStates {}

class LayoutUploadAndCreateStoryErrorState extends LayoutStates {}