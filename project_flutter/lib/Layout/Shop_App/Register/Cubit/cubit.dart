import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Login/Cubit/states.dart';
import 'package:project_flutter/Layout/Shop_App/Register/Cubit/states.dart';
import 'package:project_flutter/Models/Shop_App/login_model.dart';
import 'package:project_flutter/Network/Remote/dio_helper.dart';
import 'package:project_flutter/Network/end_point.dart';

class ShopSignUPCubit extends Cubit<ShopSignUpStates> {
  ShopSignUPCubit() : super(InitialSignUpStates()  );

  static ShopSignUPCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel shopModel;

  void userSignUp({required String email, required String password, required String name, required String phone}) {
    emit( LoadingSignUpStates());
    DioHelper.postData(url: SIGNUP, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }, token: '')
        .then((value) {
      shopModel = ShopLoginModel.fromJson(value.data);
      print(email);
      print(password);
      print(value.data);
      emit(SuccessSignUpStates(shopModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorSignUpStates(onError.toString() ));
    }); //url is end point
  }


  IconData suffix = (Icons.visibility);
  bool isPassword = true;

  void changePasswordVisible() {
    isPassword = !isPassword;
    suffix = isPassword ? (Icons.visibility) : Icons.visibility_off;
    emit(ShopChangePasswordSignUp());
  }
// void userLogin userLogin
}
