part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

//
//Get User

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserFailureState extends SocialState {
  final String error;

  SocialGetUserFailureState(this.error);
} //
//Get All User

class SocialGetAllUserLoadingState extends SocialState {}

class SocialGetAllUserSuccessState extends SocialState {}

class SocialGetAllUserFailureState extends SocialState {
  final String error;

  SocialGetAllUserFailureState(this.error);
}

//
//Get Post
class SocialGetPostLoadingState extends SocialState {}

class SocialGetPostSuccessState extends SocialState {}

class SocialGetPostFailureState extends SocialState {
  final String error;

  SocialGetPostFailureState(this.error);
}

//
// Like Post

class SocialLikePostSuccessState extends SocialState {}

class SocialLikePostFailureState extends SocialState {
  final String error;

  SocialLikePostFailureState(this.error);
}

//
//Bottom Nav Bar

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPostState extends SocialState {}

//
//Dark Mode

class SocialDarkModeSwitchState extends SocialState {}

//
//Profile Image Picked

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedFailureState extends SocialState {
  final String error;

  SocialProfileImagePickedFailureState(this.error);
}

//
//Cover Image Picked

class SocialCoverImagePickedSuccessState extends SocialState {}

class SocialCoverImagePickedFailureState extends SocialState {
  final String error;

  SocialCoverImagePickedFailureState(this.error);
}

//
//Image Post

class SocialImagePostSuccessState extends SocialState {}

class SocialImagePostFailureState extends SocialState {
  final String error;

  SocialImagePostFailureState(this.error);
}

//
//Upload Profile Image Picked

class SocialUploadProfileImagePickedSuccessState extends SocialState {}

class SocialUploadProfileImagePickedFailureState extends SocialState {
  final String error;

  SocialUploadProfileImagePickedFailureState(this.error);
}

//
//Upload Cover Image Picked

class SocialUploadCoverImagePickedSuccessState extends SocialState {}

class SocialUploadCoverImagePickedFailureState extends SocialState {
  final String error;

  SocialUploadCoverImagePickedFailureState(this.error);
}

//
//Update User

class SocialUserUpdateFailureState extends SocialState {
  final String error;

  SocialUserUpdateFailureState(this.error);
}

class SocialUserUpdateLoadingState extends SocialState {}

//
//Create Post

class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostFailureState extends SocialState {
  final String error;

  SocialCreatePostFailureState(this.error);
}

//
//Send Message
//
class SocialRemoveImagePostState extends SocialState {}

class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageFailureState extends SocialState {
  final String error;
  SocialSendMessageFailureState(this.error);
}

//
//Get Message
//
class SocialGetMessageSuccessState extends SocialState {}
