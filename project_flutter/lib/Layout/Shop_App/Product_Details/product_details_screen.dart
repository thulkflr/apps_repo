import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_flutter/Layout/Shop_App/Product_Details/Cubit/cubit.dart';
import 'package:project_flutter/Layout/Shop_App/Product_Details/Cubit/states.dart';

import '../../../Models/Shop_App/home_model.dart';

import '../Shop_Layout/Cubit/cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProductsModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit()..getProductDetails(),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
        listener: (context, state) {
        return log( 'hi ID,${ model.data?.product!.id}');

        },
        builder: (context, state) => ConditionalBuilder(
          condition: state is SuccessProductDetailsState,

          builder: (context) => buildProductDetailsItem(
              model, //data!.products![index]
              context),

          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

Widget buildProductDetailsItem(ProductsModel dataModel, context) => Scaffold(
    appBar: AppBar(
      title: Text(
        '${dataModel.name}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            height: 250,
            width: double.infinity,
            image: NetworkImage('${dataModel.image}'),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Center(
                child: Text(
                  '${dataModel.description}',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200, shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Price is: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      dataModel.price.toString(),
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    Text('\$'),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            height: 40,
            width: double.infinity,
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  ShopLayoutCubit.get(context)
                      .changeCart( dataModel.id!);

                      print('hi ID  ${dataModel. id!}');
                },
                child: changeCartButton(dataModel, context),
              ),
            ),
          )
        ],
      ),
    ));

Widget changeCartButton(  model, context) {
  if (ShopLayoutCubit.get(context).carts[model.id] == true) {
    return Text(
      'Added Successfully',
      style: TextStyle(color: Colors.white),
    );
  } else {
    return Text('Add To Cart', style: TextStyle(color: Colors.white));
  }
}
