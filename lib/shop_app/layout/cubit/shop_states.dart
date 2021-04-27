abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopErrorState extends ShopStates {
  final String error;

  ShopErrorState(this.error);
}

class ShopGetHomeLoadingState extends ShopLoadingState {}

class ShopGetHomeSucessState extends ShopStates {}

class ShopGetHomeErrorState extends ShopErrorState {
  final String error;

  ShopGetHomeErrorState(this.error) : super(error);
}

class ShopGetCategoriesLoadingState extends ShopLoadingState {}

class ShopGetCategoriesSucessState extends ShopStates {}

class ShopGetCategoriesErrorState extends ShopErrorState {
  final String error;

  ShopGetCategoriesErrorState(this.error) : super(error);
}
