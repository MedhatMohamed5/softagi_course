import './social_states.dart';

class SocialNewPostState extends SocialStates {}

class CreatePostLodingState extends SocialStates {}

class SocialpostImageSuccessState extends SocialStates {}

class SocialpostImageRemoveState extends SocialStates {}

class SocialPostImageErrorState extends SocialErrorState {
  final String error;

  SocialPostImageErrorState(this.error) : super(error);
}

class SocialpostImageUploadSuccessState extends SocialStates {}

class SocialPostImageUploadErrorState extends SocialErrorState {
  final String error;

  SocialPostImageUploadErrorState(this.error) : super(error);
}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialErrorState {
  final String error;

  CreatePostErrorState(this.error) : super(error);
}
