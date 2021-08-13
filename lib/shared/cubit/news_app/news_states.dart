abstract class NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsErrorState extends NewsStates {
  final String error;

  NewsErrorState(this.error);
}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsChangeBusinssIndexState extends NewsStates {}

class NewsIsDesktopState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsLoadingState {}

class NewsGetBusinessSucessState extends NewsStates {}

class NewsGetBusinessFailureState extends NewsErrorState {
  final String error;

  NewsGetBusinessFailureState(this.error) : super(error);
}

class NewsGetSportsLoadingState extends NewsLoadingState {}

class NewsGetSportsSucessState extends NewsStates {}

class NewsGetSportsFailureState extends NewsErrorState {
  final String error;

  NewsGetSportsFailureState(this.error) : super(error);
}

class NewsGetScienceLoadingState extends NewsLoadingState {}

class NewsGetScienceSucessState extends NewsStates {}

class NewsGetScienceFailureState extends NewsErrorState {
  final String error;

  NewsGetScienceFailureState(this.error) : super(error);
}

class NewsGetSearchLoadingState extends NewsLoadingState {}

class NewsGetSearchSucessState extends NewsStates {}

class NewsGetSearchFailureState extends NewsErrorState {
  final String error;

  NewsGetSearchFailureState(this.error) : super(error);
}
