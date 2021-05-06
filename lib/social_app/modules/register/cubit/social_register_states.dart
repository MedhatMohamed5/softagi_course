abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterShowPasswordState extends SocialRegisterStates {}

class SocialLoadingState extends SocialRegisterStates {}

class SocialErrorState extends SocialRegisterStates {
  final String error;

  SocialErrorState(this.error);
}

class SocialRegisterLoadingState extends SocialLoadingState {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialErrorState {
  final String error;
  SocialRegisterErrorState(this.error) : super(error);
}

class SocialCreateUserLoadingState extends SocialLoadingState {}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialErrorState {
  final String error;

  SocialCreateUserErrorState(this.error) : super(error);
}
