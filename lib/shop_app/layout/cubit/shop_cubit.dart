import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/home/categories_model.dart';
import 'package:udemy_flutter/shop_app/models/home/change_favorite_model.dart';
import 'package:udemy_flutter/shop_app/models/home/favorites_model.dart';
import 'package:udemy_flutter/shop_app/models/home/home_model.dart';
import 'package:udemy_flutter/shop_app/models/login/shop_login_model.dart';
import 'package:udemy_flutter/shop_app/modules/categories/categories_screen.dart';
import 'package:udemy_flutter/shop_app/modules/favorites/favorites_screen.dart';
import 'package:udemy_flutter/shop_app/modules/products/products_screen.dart';
import 'package:udemy_flutter/shop_app/modules/settings/settings_screen.dart';
import 'package:udemy_flutter/shop_app/shared/network/endpoints.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';
import 'package:udemy_flutter/shop_app/shared/network/remote/shop_dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopGetHomeLoadingState());

    ShopDioHelper.getData(
      url: HOME,
      query: null,
      lang: 'en',
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // printWrapped(value.data.toString());
      // printWrapped(homeModel.data.banners[0].image);
      // printWrapped(homeModel.data.banners[0].id.toString());

      homeModel.data?.products.forEach((element) {
        favorites.putIfAbsent(element.id, () => element.inFavorites);
      });
      // favorites[52] = true;
      // print(favorites.toString());
      emit(ShopGetHomeSucessState());
    }).catchError((error) {
      emit(ShopGetHomeErrorState(error));
    });
  }

  late CategoriesModel categoriesModel;
  void getCategoriesData() {
    emit(ShopGetCategoriesLoadingState());

    ShopDioHelper.getData(
      url: CATEGORIES,
      query: null,
      lang: 'en',
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      // printWrapped(value.data.toString());
      printWrapped(categoriesModel.data?.data![0].name);
      emit(ShopGetCategoriesSucessState());
    }).catchError((error) {
      emit(ShopGetCategoriesErrorState(error));
    });
  }

  late FavoritesModel favoritesModel;
  void getFavoritesData() {
    emit(ShopGetFavoritesLoadingState());

    ShopDioHelper.getData(
      url: FAVORITES,
      query: null,
      lang: 'en',
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      // printWrapped(value.data.toString());
      printWrapped(favoritesModel.data?.data![0].product?.name);
      emit(ShopGetFavoritesSucessState());
    }).catchError((error) {
      emit(ShopGetFavoritesErrorState(error));
    });
  }

  late ChangeFavoriteModel changeFavoriteModel;
  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopToggleFavoriteSucessState());
    ShopDioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      print(value.data);
      emit(
          ShopToggleFavoriteSucessState(message: changeFavoriteModel.message!));
    }).catchError(
      (error) {
        favorites[productId] = !favorites[productId]!;
        emit(ShopToggleFavoriteErrorState(error));
      },
    );
  }

  late ShopLoginModel userModel;
  void getUserData() {
    emit(ShopGetUserLoadingState());

    ShopDioHelper.getData(
      url: PROFILE,
      query: null,
      lang: 'en',
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      // printWrapped(value.data.toString());
      printWrapped(userModel.data?.name);
      emit(ShopGetUserSucessState(userModel));
    }).catchError((error) {
      emit(ShopGetUserErrorState(error));
    });
  }

  void updateUserData(Map<String, dynamic> data) {
    emit(ShopUpdateUserLoadingState());

    ShopDioHelper.putData(
      url: UPDATE_PROFILE,
      data: data,
      lang: 'en',
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      // printWrapped(value.data.toString());
      printWrapped(userModel.data?.name);
      emit(ShopUpdateUserSucessState(userModel));
    }).catchError((error) {
      emit(ShopUpdateUserErrorState(error));
    });
  }
}
