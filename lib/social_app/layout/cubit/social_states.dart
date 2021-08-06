abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

class SocialLoadingState extends SocialStates {}

class SocialErrorState extends SocialStates {
  final String error;

  SocialErrorState(this.error);
}

class SocialGetUserLoadingState extends SocialLoadingState {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialErrorState {
  final String error;

  SocialGetUserErrorState(this.error) : super(error);
}

class SocialProfileImageSuccessState extends SocialStates {}

class SocialProfileImageErrorState extends SocialErrorState {
  final String error;

  SocialProfileImageErrorState(this.error) : super(error);
}

class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageErrorState extends SocialErrorState {
  final String error;

  SocialCoverImageErrorState(this.error) : super(error);
}

class SocialProfileImageUploadSuccessState extends SocialStates {}

class SocialProfileImageUploadErrorState extends SocialErrorState {
  final String error;

  SocialProfileImageUploadErrorState(this.error) : super(error);
}

class SocialCoverImageUploadSuccessState extends SocialStates {}

class SocialCoverImageUploadErrorState extends SocialErrorState {
  final String error;

  SocialCoverImageUploadErrorState(this.error) : super(error);
}

class SocialUpdateUserLoadingState extends SocialStates {}

class SocialUpdateUserSuccessState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialErrorState {
  final String error;

  SocialUpdateUserErrorState(this.error) : super(error);
}
