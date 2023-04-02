import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Models/Shop_App/favorites_model.dart';
import '../../../Component/const_component.dart';
import '../../../Styles/colors.dart';
import '../Shop_Layout/Cubit/cubit.dart';
import '../Shop_Layout/Cubit/states.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopStates>(
      listener: (context, state) {
       return log('hi baby,${  ShopLayoutCubit.get(context)
           .favoritesModel
           .data!
           .data!
           .length    }');
      },
      builder: (context, state) {
        if (ShopLayoutCubit.get(context)
            .favoritesModel
            .data!
            .data!
            .length==0 ) {
          return Center(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.heart_broken, size: 70, color: Colors.grey.shade300),
                SizedBox(height: 20,),
                Text(
                  'Nothing added to Favorites ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300),
                )
              ],
            ),
          );
        }
        return ConditionalBuilder(
          condition: state is! LoadingFavDataState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavItem(
                  ShopLayoutCubit.get(context)
                      .favoritesModel
                      .data!
                      .data![index],
                  context),
              separatorBuilder: (context, index) => mySeparator(),
              itemCount: ShopLayoutCubit.get(context)
                  .favoritesModel
                  .data!
                  .data!
                  .length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildFavItem(FavoritesData dataModel, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 120,
            width: 120,
            child:
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                height: 180,
                image: NetworkImage(
                  '${dataModel.product!.image}',
                ),
                width: double.infinity,
              ),
              if (dataModel.product!.discount != 0)
                Container(
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                ),
            ]),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dataModel.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                    )),
                Spacer(),
                Row(
                  children: [
                    Text('${dataModel.product!.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    SizedBox(
                      width: 5,
                    ),
                    if (dataModel.product!.discount != 0)
                      Text('${dataModel.product!.oldPrice}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: defaultColor,
                              decoration: TextDecoration.lineThrough)),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopLayoutCubit.get(context)
                              .changeFavorites(dataModel.product!.id!);

                          //  print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              backGroundFavButtonColor(dataModel, context),
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );

Color backGroundFavButtonColor(FavoritesData model, context) {
  if (ShopLayoutCubit.get(context).favorites[model.product!.id!] == true) {
    return Colors.blueAccent;
  } else {
    return defaultColor;
  }
}
