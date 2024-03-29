import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/search/search_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
// import 'package:udemy_flutter/modules/business/business_screen.dart';
import 'package:udemy_flutter/shared/cubit/news_app/news_cubit.dart';
import 'package:udemy_flutter/shared/cubit/news_app/news_states.dart';
import 'package:udemy_flutter/shared/cubit/todo_app/app_cubit.dart';
// import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var newsCubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('New App'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: newsCubit.screens[newsCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: newsCubit.currentIndex,
            items: newsCubit.items,
            onTap: (index) {
              newsCubit.changeBottomNavBat(index);
            },
          ),
        );
      },
    );
  }
}
