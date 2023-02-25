import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Login/Cubit/states.dart';
import 'package:project_flutter/Models/Shop_App/login_model.dart';
import 'package:project_flutter/Network/Remote/dio_helper.dart';
import 'package:project_flutter/Network/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(InitialLoginStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel shopModel;

  void userLogin({required String email, required String password}) {
    emit(LoadingLoginStates());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password}, token: '')
        .then((value) {
      shopModel = ShopLoginModel.fromJson(value.data);
      print(email);
      print(password);
      print(value.data);
      emit(SuccessLoginStates(shopModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorLoginStates(onError.toString() ));
    }); //url is end point
  }

  IconData suffix = (Icons.visibility);
  bool isPassword = true;

  void changePasswordVisible() {
    isPassword = !isPassword;
    suffix = isPassword ? (Icons.visibility) : Icons.visibility_off;
    emit(ShopChangePassword());
  }
// void userLogin
}
