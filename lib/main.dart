import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:udemy_flutter/layout/news_app/news_layout.dart';
// import 'package:udemy_flutter/layout/todo_app/home_layout.dart';
// import 'package:udemy_flutter/modules/bmi/bmi_screen.dart';
// import 'package:udemy_flutter/modules/counter/counter_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
// import 'package:udemy_flutter/shared/cubit/news_app/news_cubit.dart';
import 'package:udemy_flutter/shared/cubit/todo_app/app_cubit.dart';
import 'package:udemy_flutter/shared/cubit/todo_app/app_states.dart';
// import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
// import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shop_app/modules/onboarding/onboarding_screen.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';
import 'package:udemy_flutter/shop_app/shared/network/remote/shop_dio_helper.dart';
import 'package:udemy_flutter/shop_app/shared/styles/themes.dart';
// import 'package:udemy_flutter/modules/login/login_screen.dart';
// import 'package:udemy_flutter/modules/messenger/messenger_screen.dart';
// import 'package:udemy_flutter/modules/users/users_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  // DioHelper.init();
  // await CacheHelper.init();

  ShopDioHelper.init();
  await ShopCacheHelper.init();

  bool isDark = ShopCacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;

  const MyApp({Key key, this.isDark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: this.isDark),
        ),
        /*BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),*/
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: OnboardingScreen(),
            ),
            theme: lightTheme(context),
            darkTheme: darkTheme(context),
            // themeMode: ThemeMode.system,
            themeMode: ThemeMode.light,
            //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
