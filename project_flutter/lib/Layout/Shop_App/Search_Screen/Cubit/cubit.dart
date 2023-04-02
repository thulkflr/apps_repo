import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Search_Screen/Cubit/states.dart';
import 'package:project_flutter/Models/Shop_App/search_model.dart';
import 'package:project_flutter/Network/Remote/dio_helper.dart';
import 'package:project_flutter/Network/end_point.dart';

import '../../../../Component/const_component.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

 late SearchModel searchModel;
  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {
      'text':text
    }, token: token!).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError){
      emit(SearchErrorState(onError.toString()));
    });
  }
}
