import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Cart/cart_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Categories_Screen/categories_screen.dart';
import 'package:project_flutter/Layout/Shop_App/FAV_Screen/fav_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Product_Screen/product_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/states.dart';
import 'package:project_flutter/Models/Shop_App/cart_model.dart';
import 'package:project_flutter/Models/Shop_App/categories_model.dart';
import 'package:project_flutter/Models/Shop_App/change_Cart_model.dart';
import 'package:project_flutter/Models/Shop_App/change_password.dart';
import 'package:project_flutter/Models/Shop_App/home_model.dart';
import 'package:project_flutter/Models/Shop_App/login_model.dart';

import 'package:project_flutter/Network/Remote/dio_helper.dart';
import 'package:project_flutter/Network/end_point.dart';

import '../../../../Component/const_component.dart';
import '../../../../Models/Shop_App/change_favorites_model.dart';
import '../../../../Models/Shop_App/favorites_model.dart';
import '../../Setting_Screen/setting_screen.dart';

class ShopLayoutCubit extends Cubit<ShopStates> {
  ShopLayoutCubit() : super(InitialShopState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavScreen(),
    const CartScreen(),
    SettingScreen(),
  ];

  void bottomChange(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late HomeModel? homeModel = HomeModel();

  Map<int, bool?> favorites = {};
  Map<int, bool?> carts = {};

  void getHomeData() {
    emit(LoadingShopDataState());
    DioHelper.getData(url: HOME, token: token!, query: {'': 'null'})
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites,
        });
      });
      // homeModel.data!.products!.forEach((element) {
      //   favorites.addAll({
      //     element.id!: element.inCart,
      //   });
      // });

      // print(favorites.toString());

      emit(SuccessShopDataState());
      print(carts);
      //print(favorites.toString());
    }).catchError((onError) {
      print('hi');

      emit(ErrorShopDataState(onError.toString()));
    });
  }

  late CategoriesModel? categoriesModel = CategoriesModel();

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: '', query: {'': 'null'})
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(SuccessCategoriesDataState());
    }).catchError((onError) {
      emit(ErrorCategoriesDataState(onError.toString()));
    });
  }

  late ShopLoginModel userModel;

  void getUsers() {
    emit(LoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token!, query: {'': 'null'})
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(SuccessGetUserDataState(userModel));
    }).catchError((onError) {
      emit(ErrorGetUserDataState(onError.toString()));
    });
  }

  late ShopLoginModel userUpdateModel;

  void updateUsersData(
      {required String name,
      required String email,
      required String phoneNumber}) {
    emit(LoadingUpdateUserDataState());

    DioHelper.putData(
            url: UPDATE_PROFILE,
            token: token!,
            data: {'name': name, 'email': email, 'phone': phoneNumber})
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.dataa!.name!);
      emit(SuccessUpdateUserDataState(userModel));
    }).catchError((onError) {
      emit(ErrorUpdateUserDataState(onError.toString()));
    });
  }

  late ChangeFavoritsModel changeFavoritsModel;

  void changeFavorites(int productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ChangeFavoritsDataState());

    DioHelper.postData(
            url: FAVORITE,
            data: {
              'product_id': productID,
            },
            token: token!)
        .then((value) {
      changeFavoritsModel = ChangeFavoritsModel.fromJson(value.data);
      //print(value.data);
      if (!changeFavoritsModel.status) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getFavorites();
      }
      emit(SuccessChangeFavoritsDataState(changeFavoritsModel));
    }).catchError((onError) {
      favorites[productID] = !favorites[productID]!;

      emit(ErrorChangeFavoritsDataState(onError.toString()));
    });
  }

  late FavoritesModel favoritesModel;

  void getFavorites() {
    emit(LoadingFavDataState());

    DioHelper.getData(url: FAVORITE, token: token!, query: {'': 'null'})
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(SuccessGetFavDataState());
    }).catchError((onError) {
      emit(ErrorGetFavoritsDataState(onError.toString()));
    });
  }

  late ChangeCartModel changeCartModel;

  void changeCart(int productID) {
    carts[productID] = !carts[productID]!;
    emit(ChangeFavoritsDataState());

    DioHelper.postData(
            url: CARTS,
            data: {
              'product_id': productID,
            },
            token: token!)
        .then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data!);
      //print(value.data);
      if (!changeCartModel.status) {
        carts[productID] = !carts[productID]!;
      } else {
        getFavorites();
      }
      emit(SuccessChangeCartDataState(changeCartModel));
    }).catchError((onError) {
      carts[productID] = !carts[productID]!;

      emit(ErrorChangeCartDataState(onError.toString()));
    });
  }

  late GetDataCartModel cartModel = GetDataCartModel();

  void getCartsData() {
    emit(LoadingCartDataState());

    DioHelper.getData(url: CARTS, token: token!, query: {'': 'null'})
        .then((value) {
      cartModel = GetDataCartModel.fromJson(value.data!);
//print(value.data.toString());

      emit(SuccessGetCartDataState());
    }).catchError((onError) {
      emit(ErrorGetCartDataState(onError.toString()));
    });
  }

  late ChangePasswordModel passwordModel=ChangePasswordModel();

  void changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    emit(LoadingUpdatePasswordDataState());

    DioHelper.postData(url: CHANGE_PASSWORD, token: token!, data: {
      'current_password': oldPassword,
      'new_password': newPassword,
    }).then((value) {
      passwordModel = ChangePasswordModel.fromJson(value.data);
      print(passwordModel.data!);
      emit(SuccessUpdatePasswordDataState(passwordModel));
    }).catchError((onError) {
      emit(ErrorUpdatePasswordDataState(onError.toString()));
    });
  }
}
