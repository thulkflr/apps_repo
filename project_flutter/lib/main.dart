import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Cubit/cubit.dart';
import 'package:project_flutter/Cubit/states.dart';
import 'package:project_flutter/Layout/Shop_App/Login/login_screen.dart';
import 'package:project_flutter/Layout/Shop_App/On_Boarding/on_boardig.dart';
import 'package:project_flutter/Network/Remote/dio_helper.dart';

import 'Component/const_component.dart';
import 'Const/bloc_observe.dart';
import 'Layout/News_App/Cubit/cubit.dart';

import 'Layout/Shop_App/Shop_Layout/Cubit/cubit.dart';
import 'Layout/Shop_App/Shop_Layout/shop_layout.dart';
import 'Network/Remote/shared_helper.dart';
import 'Styles/Theames/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Prefs.init();
  Widget widget;
  bool? isDark = Prefs.getBooleanValue('isDark');
  bool? onBoarding = Prefs.getBooleanValue('onBoarding');
  token = Prefs.getBooleanValue('token');
  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  )); //isDark: isDark!
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp(
      {super.key,
      this.isDark,
      required this.startWidget}); //, required this.isDark

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getTelsa()
            ..getFord()
            ..getJaguar(),
        ),
        BlocProvider(
            create: (BuildContext context) =>
                CounterCubit()..changeAppTheme(change: isDark)),
        BlocProvider(
          create: (BuildContext context) => ShopLayoutCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUsers()
            ..getCartsData(), //change: isDark
        )
      ],
      child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              title: 'Flutter Demo',
              theme: lightTheme,
              // darkTheme: darkTheme,
              //themeMode: ThemeMode.light,
              // themeMode:
              // CounterCubit.get(context).isDark
              //     ? ThemeMode.dark
              //     : ThemeMode.light,
              home: startWidget,
            );
          }),
    );
  }
}
