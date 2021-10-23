import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/layout/store_layout.dart';
import 'package:store_app/modules/Login_screen/cubit/cubit.dart';
import 'package:store_app/modules/home.dart';
import 'package:store_app/modules/landingPage/landing_page.dart';
import 'package:store_app/shared/bloc_observer.dart';
import 'package:store_app/shared/constants/constant.dart';
import 'package:store_app/styles/themes/themes.dart';

import 'modules/Login_screen/cubit/states.dart';
import 'modules/Login_screen/login_screen.dart';
import 'modules/sign_up_screen/cubit/cubit.dart';
import 'network/local/cache_helper.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  if (uId != null) {
    widget = StoreLayout();
  } else {
    widget = LandingPage();
  }

  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark: isDark,startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({this.startWidget,this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => StoreAppCubit()..changeThemeMode(fromShared: isDark)..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<StoreAppCubit,StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: StoreAppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

