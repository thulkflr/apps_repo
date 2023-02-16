import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Cubit/cubit.dart';
import 'package:project_flutter/Cubit/states.dart';
import 'package:project_flutter/Network/Remote/dio_helper.dart';

import 'Const/bloc_observe.dart';
import 'Layout/News_App/Cubit/cubit.dart';
import 'Layout/News_App/news_layout.dart';
import 'Network/Remote/shared_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Prefs.init();
  bool? isDark = Prefs.getBooleanValue('isDark');
  runApp(MyApp(isDark: isDark));//isDark: isDark!
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({super.key, this.isDark});//, required this.isDark

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
              CounterCubit()..changeAppTheme(change: isDark),//change: isDark
        )
      ],
      child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.amber,
                  appBarTheme: const AppBarTheme(
                    titleSpacing: 20,
                    color: Colors.white,
                    titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarBrightness: Brightness.dark,
                        statusBarColor: Colors.black12),
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  bottomNavigationBarTheme:
                      const BottomNavigationBarThemeData(
                          unselectedItemColor: Colors.black,
                          elevation: 20.0,
                          selectedItemColor: Colors.orangeAccent,
                          backgroundColor: Colors.white10,
                          type: BottomNavigationBarType.fixed),
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                          backgroundColor: Colors.orange)),
              darkTheme: ThemeData.dark(),
              themeMode: CounterCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const NewsLayout(),
            );
          }),
    );
  }
}
