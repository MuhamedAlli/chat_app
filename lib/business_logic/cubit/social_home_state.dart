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
