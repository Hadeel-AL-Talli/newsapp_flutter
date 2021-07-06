import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/appcubit.dart';
import 'package:news_app/cubit/appstate.dart';
import 'package:news_app/cubit/cuibt.dart';

import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/newsApp/layout/newslayout.dart';
import 'package:news_app/shopApp/onBoarding.dart';
import 'package:news_app/style/themes.dart';
import 'package:news_app/styles/bloc_observer.dart';

void main() async {
  // to ensure that all methed has been done before runApp
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness(),),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark),)
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: OnBoarding()
            // NewsLayout(),
            );
          }),
    );
  }
}
