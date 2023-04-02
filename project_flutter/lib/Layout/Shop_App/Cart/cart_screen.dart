import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Component/const_component.dart';
import '../../../Models/Shop_App/cart_model.dart';
import '../../../Styles/colors.dart';
import '../Shop_Layout/Cubit/cubit.dart';
import '../Shop_Layout/Cubit/states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopStates>(
      listener: (context, state) {
     //   return log('hi baby,${  ShopLayoutCubit.get(context).cartModel.data!.cartItems![1].product!.name  }');
      },
      builder: (context, state) {
        if(ShopLayoutCubit.get(context).carts.isEmpty)
        {return Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove_shopping_cart,size: 70,color: Colors.grey.shade300),
              SizedBox(height: 20,),

              Text('Nothing added to Cart ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade300),)
            ],
          ),
        );}
        return  ConditionalBuilder(
          condition: state is! LoadingCartDataState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCartItem(
                  ShopLayoutCubit.get(context).cartModel.data!.cartItems![index],
                  context),
              separatorBuilder: (context, index) => mySeparator(),
              itemCount:
                  ShopLayoutCubit.get(context).cartModel.data!.cartItems!.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildCartItem(CartItems itemModel, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 120,
            width: 120,
            child: Image(
              height: 120,
              image: NetworkImage(
                itemModel.product!.image!,
              ),
              width: double.infinity,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemModel.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                    )),
                Spacer(),
                Row(
                  children: [
                    Text('${itemModel.product!.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    SizedBox(
                      width: 5,
                    ),
                    if (itemModel.product!.discount != 0)
                      Text('${itemModel.product!.oldPrice}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: defaultColor,
                              decoration: TextDecoration.lineThrough)),
                    Spacer(),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
