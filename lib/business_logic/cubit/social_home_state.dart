part of 'social_home_cubit.dart';

@immutable
abstract class SocialMainState {}

class SocialMainInitial extends SocialMainState {}

class SocialMainLoadingState extends SocialMainState {}

class SocialMainSuccessState extends SocialMainState {
  final UserModel userModel;
  SocialMainSuccessState(this.userModel);
}

class SocialMainFailureState extends SocialMainState {
  final String error;
  SocialMainFailureState(this.error);
}

class SocialMainChangeState extends SocialMainState {}

class SocialSignOutState extends SocialMainState {}

class SocialAddPostState extends SocialMainState {}

class SocialProfileImagePickedSuccessState extends SocialMainState {}

class SocialProfileImagePickedErrorState extends SocialMainState {}

class SocialCoverImagePickedSuccessState extends SocialMainState {}

class SocialCoverImagePickedErrorState extends SocialMainState {}

class SocialUploadCoverImageSuccessState extends SocialMainState {}

class SocialUploadCoverImageErrorState extends SocialMainState {}

class SocialUploadProfileImageSuccessState extends SocialMainState {}

class SocialUploadProfileImageErrorState extends SocialMainState {}

class SocialUpdateUserDataErroeState extends SocialMainState {}

class SocialLoadingUpdateUserDataState extends SocialMainState {}
//picked post image

class SocialPostImagePickedSuccessState extends SocialMainState {}

class SocialPostImagePickedErrorState extends SocialMainState {}

class SocialRemovePostImagePickedErrorState extends SocialMainState {}

//upload post image
class SocialUploadPostImageSuccessState extends SocialMainState {}

class SocialUploadPostImageErrorState extends SocialMainState {}

//Create post
class SocialLoadingCreatePostState extends SocialMainState {}

class SocialCreatePostSuccessState extends SocialMainState {}

class SocialCreatePostErrorState extends SocialMainState {}
//get posts

class SocialGetPostSuccessState extends SocialMainState {}

class SocialGetPostErrorState extends SocialMainState {
 final String error;
  SocialGetPostErrorState(this.error);
}
//get all users

class SocialGetAllUsersSuccessState extends SocialMainState {}

class SocialGetAllUsersErrorState extends SocialMainState {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}
//like post
class SocialLikePostSuccessState extends SocialMainState {}

class SocialLikePostErrorState extends SocialMainState {
  final String error;
  SocialLikePostErrorState(this.error);
}
//send message
class SocialSendMessageSuccessState extends SocialMainState {}

class SocialSendMessageErrorState extends SocialMainState {}

//Get message
class SocialGetMessageSuccessState extends SocialMainState {
final  List<MessageModel> messages ;
  SocialGetMessageSuccessState(this.messages);
}

class SocialGetMessageErrorState extends SocialMainState {}
