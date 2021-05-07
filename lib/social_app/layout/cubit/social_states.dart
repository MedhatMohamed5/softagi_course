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
