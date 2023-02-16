import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Cubit/states.dart';
import 'package:project_flutter/Layout/News_App/Cubit/states.dart';
import '../Network/Remote/shared_helper.dart';
import 'Network/Remote/shared_helper.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(InitCounterState());

  static CounterCubit get(context) => BlocProvider.of(
      context); //to create an object of counter cubit in any class ++++_
  bool isDark = false;

  void changeAppTheme({bool? change}) {
    if (change != null) {
      isDark = change;
      emit(ChangeAppThemeState());
    } else {
      isDark = !isDark;
      Prefs.setBooleanValue('isDark', isDark).then((value) {
        emit(ChangeAppThemeState());
      });
    }
  }
}
