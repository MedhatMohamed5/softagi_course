import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:responsive_builder/responsive_builder.dart';
import 'package:udemy_flutter/native_code_screen.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:udemy_flutter/layout/news_app/news_layout.dart';
// import 'package:udemy_flutter/layout/todo_app/home_layout.dart';
// import 'package:udemy_flutter/modules/bmi/bmi_screen.dart';
// import 'package:udemy_flutter/modules/counter/counter_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
// import 'package:udemy_flutter/shared/cubit/news_app/news_cubit.dart';
import 'package:udemy_flutter/shared/cubit/todo_app/app_cubit.dart';
import 'package:udemy_flutter/shared/cubit/todo_app/app_states.dart';
// import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
// import 'package:udemy_flutter/shop_app/modules/login/shop_login_screen.dart';
// import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
// import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
// import 'package:udemy_flutter/shop_app/modules/onboarding/onboarding_screen.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';
import 'package:udemy_flutter/shop_app/shared/network/remote/shop_dio_helper.dart';
// import 'package:udemy_flutter/shop_app/shared/styles/themes.dart';
// import 'package:udemy_flutter/social_app/layout/cubit/social_cubit.dart';
// import 'package:udemy_flutter/social_app/layout/social_layout.dart';
// import 'package:udemy_flutter/modules/login/login_screen.dart';
// import 'package:udemy_flutter/modules/messenger/messenger_screen.dart';
// import 'package:udemy_flutter/modules/users/users_screen.dart';
// import 'package:udemy_flutter/shop_app/layout/shop_layout.dart';
// import 'package:udemy_flutter/social_app/modules/login/social_login_screen.dart';
import 'package:udemy_flutter/social_app/shared/components/components.dart';
// import 'package:udemy_flutter/social_app/shared/network/local/social_cache_helper.dart';
import 'package:udemy_flutter/social_app/shared/styles/themes.dart';

import 'shared/cubit/news_app/news_cubit.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(
    message: message.data.toString(),
    backgroundColor: Colors.greenAccent,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print("Message Token $token");

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(
      message: event.data.toString(),
      backgroundColor: Colors.greenAccent,
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(
      message: event.data.toString(),
      backgroundColor: Colors.greenAccent,
    );
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
*/
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  ShopDioHelper.init();
  await ShopCacheHelper.init();

  //await SocialCacheHelper.init();

  bool isDark = ShopCacheHelper.getData(key: 'isDark');
  // bool onBoarding = ShopCacheHelper.getData(key: 'onBoarding');
  //String token = ShopCacheHelper.getData(key: 'token');

  //String uid = SocialCacheHelper.getData(key: 'uid');
  //print(token);
  Widget startWidget;

  /*if (onBoarding != null) {
    if (token != null)
      startWidget = ShopLayout();
    else
      startWidget = ShopLoginScreen();
  } else {
    startWidget = OnboardingScreen();
  }*/
  //startWidget = uid != null ? SocialLayout() : SocialLoginScreen();

  // startWidget = NewsLayout();
  startWidget = NativeCodeScreen();

  if (Platform.isWindows) DesktopWindow.setMinWindowSize(Size(350, 650));

  runApp(MyApp(
    isDark: isDark,
    startWidget: startWidget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  const MyApp({Key key, this.isDark, this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: this.isDark),
        ),
        /*BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
          // ..getUsers(),
        ),*/
        /*BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData(),
        ),*/
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: startWidget,
            ),

            theme: lightTheme(context),
            darkTheme: darkTheme(context),
            // themeMode: ThemeMode.system,
            themeMode: //ThemeMode.light,
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
