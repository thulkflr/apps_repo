import 'package:project_flutter/Models/Shop_App/change_Cart_model.dart';
import 'package:project_flutter/Models/Shop_App/change_favorites_model.dart';
import 'package:project_flutter/Models/Shop_App/change_password.dart';

import 'package:project_flutter/Models/Shop_App/login_model.dart';

//ShopLayout
abstract class ShopStates {}

class InitialShopState extends ShopStates {}

class LoadingShopDataState extends ShopStates {}

class SuccessShopDataState extends ShopStates {}

class ErrorShopDataState extends ShopStates {
  final String error;

  ErrorShopDataState(this.error);
}

//Categories
class SuccessCategoriesDataState extends ShopStates {}

class ErrorCategoriesDataState extends ShopStates {
  final String error;

  ErrorCategoriesDataState(this.error);
}

//bottomNavigationBar
class ShopChangeBottomNavState extends ShopStates {}

//favorite
class SuccessChangeFavoritsDataState extends ShopStates {
  final ChangeFavoritsModel model;

  SuccessChangeFavoritsDataState(this.model);
}

class ChangeFavoritsDataState extends ShopStates {}

class ErrorChangeFavoritsDataState extends ShopStates {
  final String error;

  ErrorChangeFavoritsDataState(this.error);
}

class LoadingFavDataState extends ShopStates {}

class SuccessGetFavDataState extends ShopStates {}

class ErrorGetFavoritsDataState extends ShopStates {
  final String error;

  ErrorGetFavoritsDataState(this.error);
}

//User data
class LoadingUserDataState extends ShopStates {}

class SuccessGetUserDataState extends ShopStates {
  ShopLoginModel loginModel;

  SuccessGetUserDataState(this.loginModel);
}

class ErrorGetUserDataState extends ShopStates {
  final String error;

  ErrorGetUserDataState(this.error);
}

class LoadingUpdateUserDataState extends ShopStates {}

class SuccessUpdateUserDataState extends ShopStates {
  ShopLoginModel loginModel;

  SuccessUpdateUserDataState(this.loginModel);
}

class ErrorUpdateUserDataState extends ShopStates {
  final String error;

  ErrorUpdateUserDataState(this.error);
}

//Cart
class SuccessChangeCartDataState extends ShopStates {
  final ChangeCartModel model;

  SuccessChangeCartDataState(this.model);
}

class ChangeCartDataState extends ShopStates {}

class ErrorChangeCartDataState extends ShopStates {
  final String error;

  ErrorChangeCartDataState(this.error);
}

class LoadingCartDataState extends ShopStates {}

class SuccessGetCartDataState extends ShopStates {}

class ErrorGetCartDataState extends ShopStates {
  final String error;

  ErrorGetCartDataState(this.error);
}

class LoadingUpdatePasswordDataState extends ShopStates {}

class SuccessUpdatePasswordDataState extends ShopStates {
  ChangePasswordModel passwordModel ;

  SuccessUpdatePasswordDataState(this.passwordModel);
}

class ErrorUpdatePasswordDataState extends ShopStates {
  final String error;

  ErrorUpdatePasswordDataState(this.error);
}
