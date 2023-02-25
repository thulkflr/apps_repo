import 'package:project_flutter/Models/Shop_App/change_favorites_model.dart';
import 'package:project_flutter/Models/Shop_App/home_model.dart';

abstract class ShopStates {}

class InitialShopState extends ShopStates {}

class LoadingShopDataState extends ShopStates {}

class SuccessShopDataState extends ShopStates {
  // HomeModel homeModel;
  //
  // SuccessShopDataState(this.homeModel);
}

class ErrorShopDataState extends ShopStates {
  final String error;

  ErrorShopDataState(this.error);
}

class SuccessCategoriesDataState extends ShopStates {}

class ErrorCategoriesDataState extends ShopStates {
  final String error;

  ErrorCategoriesDataState(this.error);
}

class SuccessChangeFavoritsDataState extends ShopStates {
    final ChangeFavoritsModel model;

    SuccessChangeFavoritsDataState(this.model);
}
class ChangeFavoritsDataState extends ShopStates {}

class ErrorChangeFavoritsDataState extends ShopStates {
  final String error;

  ErrorChangeFavoritsDataState(this.error);
}

class ShopChangeBottomNavState extends ShopStates {}
