import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/business/business_screen.dart';
import 'package:udemy_flutter/modules/science/science_screen.dart';
import 'package:udemy_flutter/modules/settings/news_settings_screen.dart';
import 'package:udemy_flutter/modules/sports/sports_screen.dart';
import 'package:udemy_flutter/shared/cubit/news_app/news_states.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(BuildContext context) =>
      BlocProvider.of<NewsCubit>(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_esports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    NewsSettingsScreen(),
  ];
  void changeBottomNavBat(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
    if (index == 1)
      getSports();
    else if (index == 2) getScience();
  }

  List<Map<String, dynamic>> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: 'top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apikey': 'bbfd1d1e40ea474a97003c37b2f2a103',
      }).then((value) {
        // printWrapped(value.data['articles'][1]['title']);
        business = (value.data['articles'] as List)
            .map((e) => e as Map<String, dynamic>)
            ?.toList();
        // printWrapped(business.toString());
        emit(NewsGetBusinessSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessFailureState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSucessState());
    }
  }

  List<Map<String, dynamic>> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': 'bbfd1d1e40ea474a97003c37b2f2a103',
      }).then((value) {
        // printWrapped(value.data['articles'][1]['title']);
        sports = (value.data['articles'] as List)
            .map((e) => e as Map<String, dynamic>)
            ?.toList();
        // printWrapped(business.toString());
        emit(NewsGetSportsSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsFailureState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  List<Map<String, dynamic>> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': 'bbfd1d1e40ea474a97003c37b2f2a103',
      }).then((value) {
        // printWrapped(value.data['articles'][1]['title']);
        science = (value.data['articles'] as List)
            .map((e) => e as Map<String, dynamic>)
            ?.toList();
        // printWrapped(business.toString());
        emit(NewsGetScienceSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceFailureState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }
}
