import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Product_Details/Cubit/states.dart';
import 'package:project_flutter/Network/end_point.dart';

import '../../../../Component/const_component.dart';
import '../../../../Models/Shop_App/home_model.dart';
import '../../../../Network/Remote/dio_helper.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates>
{

  ProductDetailsCubit():super(InitialProductDetailsState());
  static ProductDetailsCubit get(context)=>BlocProvider.of(context);

  late ProductsModel productDetailsModel =ProductsModel();

  void getProductDetails()
  {
    emit(LoadingProductDetailsState());

    DioHelper.getData(url: PRODUCT_DETAILS, token: token!, query: {'': 'null'})
        .then((value) {
      productDetailsModel = ProductsModel.fromJson(value.data);

     print('this is the value ${value.data.toString()}');
      emit(SuccessProductDetailsState());
    }).catchError((onError) {
      emit(ErrorProductDetailsState(onError.toString()));
    });
  }
}