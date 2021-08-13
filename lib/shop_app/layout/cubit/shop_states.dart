import 'package:udemy_flutter/shop_app/models/login/shop_login_model.dart';

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

class ShopGetFavoritesLoadingState extends ShopLoadingState {}

class ShopGetFavoritesSucessState extends ShopStates {}

class ShopGetFavoritesErrorState extends ShopErrorState {
  final String error;

  ShopGetFavoritesErrorState(this.error) : super(error);
}

class ShopGetUserLoadingState extends ShopLoadingState {}

class ShopGetUserSucessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopGetUserSucessState(this.loginModel);
}

class ShopGetUserErrorState extends ShopErrorState {
  final String error;

  ShopGetUserErrorState(this.error) : super(error);
}

class ShopUpdateUserLoadingState extends ShopLoadingState {}

class ShopUpdateUserSucessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopUpdateUserSucessState(this.loginModel);
}

class ShopUpdateUserErrorState extends ShopErrorState {
  final String error;

  ShopUpdateUserErrorState(this.error) : super(error);
}

class ShopToggleFavoriteSucessState extends ShopStates {
  final String? message;

  ShopToggleFavoriteSucessState({this.message});
}

class ShopToggleFavoriteErrorState extends ShopErrorState {
  final String error;

  ShopToggleFavoriteErrorState(this.error) : super(error);
}
