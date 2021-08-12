import './social_states.dart';

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialErrorState {
  final String error;

  SocialSendMessageErrorState(this.error) : super(error);
}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialErrorState {
  final String error;

  SocialGetMessageErrorState(this.error) : super(error);
}
