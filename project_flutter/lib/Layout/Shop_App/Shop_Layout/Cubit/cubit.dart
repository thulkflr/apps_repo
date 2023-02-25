import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Categories_Screen/categories_screen.dart';
import 'package:project_flutter/Layout/Shop_App/FAV_Screen/fav_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Product_Screen/product_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/states.dart';
import 'package:project_flutter/Models/Shop_App/categories_model.dart';
import 'package:project_flutter/Models/Shop_App/home_model.dart';
import 'package:project_flutter/Modules/News_App/Settings/setting_screen.dart';
import 'package:project_flutter/Network/Remote/dio_helper.dart';
import 'package:project_flutter/Network/end_point.dart';

import '../../../../Component/const_component.dart';
import '../../../../Models/Shop_App/change_favorites_model.dart';

class ShopLayoutCubit extends Cubit<ShopStates> {
  ShopLayoutCubit() : super(InitialShopState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavScreen(),
    const Setting_Screen(),
  ];

  void bottomChange(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  late HomeModel homeModel = HomeModel(status: true);

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(LoadingShopDataState());

    DioHelper.getData(url: HOME, token: token, query: {'': 'null'})
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data!.products!.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

     // print(favorites.toString());

      emit(SuccessShopDataState());
      print(favorites.toString());

    }).catchError((onError) {
      print('hi');

      emit(ErrorShopDataState(onError.toString()));
    });
  }

  late CategoriesModel categoriesModel = CategoriesModel();

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: '', query: {'': 'null'})
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(SuccessCategoriesDataState());
    }).catchError((onError) {
      emit(ErrorCategoriesDataState(onError.toString()));
    });
  }


 late ChangeFavoritsModel changeFavoritsModel ;
  void changeFavorites(int productID)
  {
    favorites[productID]=!favorites[productID]!;
    emit( ChangeFavoritsDataState());

    DioHelper.postData(url: FAVORITE, data: {
      'product_id':productID,
    },token: token).then((value) {
      changeFavoritsModel=ChangeFavoritsModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritsModel.status )
        {
          favorites[productID]=!favorites[productID]!;

        }
      emit(SuccessChangeFavoritsDataState(changeFavoritsModel));
    }).catchError((onError){
      favorites[productID]=!favorites[productID]!;

      emit(ErrorChangeFavoritsDataState(onError.toString()));
    });
  }
}

