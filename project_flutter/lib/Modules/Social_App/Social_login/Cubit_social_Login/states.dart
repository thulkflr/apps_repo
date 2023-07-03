import 'package:project_flutter/Models/Shop_App/login_model.dart';

abstract class SocialLoginStates{}
  class InitialLoginStates extends SocialLoginStates{}
  class LoadingLoginStates extends SocialLoginStates{}
  class SuccessLoginStates extends SocialLoginStates{

  }
  class ErrorLoginStates extends SocialLoginStates{
    final String error;

  ErrorLoginStates(this.error );
  }
class SocialChangePassword extends SocialLoginStates{}
