import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/models/home/search_model.dart';
import 'package:udemy_flutter/shop_app/modules/search/cubit/search_states.dart';
import 'package:udemy_flutter/shop_app/shared/network/endpoints.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';
import 'package:udemy_flutter/shop_app/shared/network/remote/shop_dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(BuildContext context) =>
      BlocProvider.of<SearchCubit>(context);

  late SearchModel searchModel;

  void search(String text) {
    emit(SearchLoadingState());
    ShopDioHelper.postData(
      url: SEARCH,
      data: {'text': text},
      authorizationToken: ShopCacheHelper.getData(key: 'token'),
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      printWrapped('${value.data}');
      emit(SearchSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }
}
