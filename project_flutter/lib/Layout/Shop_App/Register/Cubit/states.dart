

import '../../../../Models/Shop_App/login_model.dart';

abstract class ShopSignUpStates{}
  class InitialSignUpStates extends ShopSignUpStates{}
  class LoadingSignUpStates extends ShopSignUpStates{}
  class SuccessSignUpStates extends ShopSignUpStates{
  final ShopLoginModel loginModel  ;
  SuccessSignUpStates(this.loginModel);
  }
  class ErrorSignUpStates extends ShopSignUpStates{
    final String error;

  ErrorSignUpStates(this.error );
  }
class ShopChangePasswordSignUp extends ShopSignUpStates{}
