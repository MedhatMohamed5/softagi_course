abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSucessState extends NewsStates {}

class NewsGetBusinessFailureState extends NewsStates {
  final String error;

  NewsGetBusinessFailureState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSucessState extends NewsStates {}

class NewsGetSportsFailureState extends NewsStates {
  final String error;

  NewsGetSportsFailureState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSucessState extends NewsStates {}

class NewsGetScienceFailureState extends NewsStates {
  final String error;

  NewsGetScienceFailureState(this.error);
}
