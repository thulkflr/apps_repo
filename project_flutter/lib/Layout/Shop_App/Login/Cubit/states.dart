import 'package:project_flutter/Models/Shop_App/login_model.dart';

abstract class ShopLoginStates{}
  class InitialLoginStates extends ShopLoginStates{}
  class LoadingLoginStates extends ShopLoginStates{}
  class SuccessLoginStates extends ShopLoginStates{
  final ShopLoginModel loginModel;
  SuccessLoginStates(this.loginModel);
  }
  class ErrorLoginStates extends ShopLoginStates{
    final String error;

  ErrorLoginStates(this.error );
  }
class ShopChangePassword extends ShopLoginStates{}
