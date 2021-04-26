import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/home/home_model.dart';
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

  HomeModel model;

  void getHomeData() {
    emit(ShopGetHomeLoadingState());

    ShopDioHelper.getData(
      url: HOME,
      query: null,
      lang: 'en',
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      model = HomeModel.fromJson(value.data);

      // printWrapped(value.data.toString());
      printWrapped(model.data.banners[0].image);
      printWrapped(model.data.banners[0].id.toString());
      emit(ShopGetHomeSucessState());
    }).catchError((error) {
      emit(ShopGetHomeErrorState(error));
    });
  }
}
