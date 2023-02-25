import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/News_App/Cubit/states.dart';


import '../../../Modules/News_App/Ford/ford_screen.dart';
import '../../../Modules/News_App/Jaguar/jaguar_screen.dart';
import '../../../Modules/News_App/Settings/setting_screen.dart';
import '../../../Modules/News_App/Tesla/tesla_screen.dart';
import '../../../Network/Remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInit());

  static NewsCubit get(context) => BlocProvider.of(context);
  int current_index = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.electric_bolt), label: 'Tesla'),
    BottomNavigationBarItem(icon: Icon(Icons.car_crash_rounded), label: 'Ford'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Jaguar'),
    //   BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> Screens = [
    Tesla_Screen(),
    Ford_Screen(),
    Jaguar_Screen(),
    Setting_Screen()
  ];

  void changeBottomNavBar(int index) {
    current_index = index;

    emit(NewsNavigation());
  }

  List<dynamic> teslas = [];
//https://newsapi.org/v2/everything?q=tesla&from=2023-01-16&sortBy=publishedAt&apiKey=e056ffa0ad954ad6bb1cb6d21f31647e
  void getTelsa() {
    emit(NewsGetTeslaSLoading());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': 'tesla',
      'from': '2023-01-16',
      'sortBy': 'publishedAt',
      'apiKey': 'e056ffa0ad954ad6bb1cb6d21f31647e',
    }, token: '').then((value) {
      //print (value.data.toString());
      teslas = value.data['articles'];
      print(teslas[5]['title']);

      emit(NewsGetTeslaSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetTeslaError(onError.toString()));
    });
  }

  List<dynamic> fords = [];

  void getFord() {
    emit(NewsGetFordLoading());
    if (fords.length == 0) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q': 'ford',
        'from': '2023-01-16',
        'sortBy': 'publishedAt',
        'apiKey': 'e056ffa0ad954ad6bb1cb6d21f31647e',
      }, token: '').then((value) {
        //print (value.data.toString());
        fords = value.data['articles'];
        // print (teslas[5]['title']);

        emit(NewsGetFordSuccess());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetFordError(onError.toString()));
      });
    } else {
      emit(NewsGetFordSuccess());
    }
  }

  List<dynamic> jauars = [];

  void getJaguar() {
    emit(NewsGetJaguarLoading());
    if (jauars.length == 0) {
      DioHelper.getData(url: 'v2/everything', query: {
        'q': 'jaguar',
        'from': '2023-01-16',
        'sortBy': 'publishedAt',
        'apiKey': 'e056ffa0ad954ad6bb1cb6d21f31647e',
      }, token: '').then((value) {
        //print (value.data.toString());
        jauars = value.data['articles'];
        //print (teslas[5]['title']);

        emit(NewsGetJaguarSuccess());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetJaguarError(onError.toString()));
      });
    } else {
      emit(NewsGetJaguarSuccess());
    }
  }

  List<dynamic> searches = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoading());
    //  searches=[];//عشان كل ما اجي اعمل بحث يكون الفورم فاضي مش مخزن الي بحث عنه قبل

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': 'e056ffa0ad954ad6bb1cb6d21f31647e',
    }, token: '').then((value) {
      //print (value.data.toString());
      searches = value.data['articles'];
      //print (teslas[5]['title']);

      emit(NewsGetSearchSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchError(onError.toString()));
    });
  }
}
