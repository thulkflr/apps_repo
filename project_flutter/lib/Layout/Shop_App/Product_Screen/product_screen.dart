import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Component/const_component.dart';
import 'package:project_flutter/Layout/Shop_App/Product_Details/product_details_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/cubit.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/states.dart';
import 'package:project_flutter/Models/Shop_App/favorites_model.dart';
import 'package:project_flutter/Models/Shop_App/home_model.dart';
import 'package:project_flutter/Styles/colors.dart';

import '../../../Models/Shop_App/categories_model.dart';
import '../Product_Details/Cubit/cubit.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavoritsDataState) {
          if (!state.model.status) {
            showToast(
                msg: state.model.message,
                states: ToastStates.ERORR,
                context: context);
          }
        }
      },
      builder: (context, state) {
        if(ShopLayoutCubit.get(context).categoriesModel!.data?.data!.length == 0)
        {return Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.waving_hand,size: 70,color: Colors.grey.shade300),
              Text('Home not Empty',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade300),)
            ],
          ),
        );}
        return ConditionalBuilder(
          builder: (context) {
            return homeProductsBuilder(ShopLayoutCubit.get(context).homeModel,
                ShopLayoutCubit.get(context).categoriesModel,  context);
          },
          fallback: (context) {
            if (state is! SuccessShopDataState) {
              return Center(child: CircularProgressIndicator());
            }
            else{
                return Center(child: CircularProgressIndicator());
              }
            },
          condition: (ShopLayoutCubit.get(context).homeModel != null &&
              ShopLayoutCubit.get(context).categoriesModel != null  )
        );
      },
    );
  }

  Widget homeProductsBuilder(
          HomeModel? model, CategoriesModel? catModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
            items: model!.data?.banners!.map((e) {
              return Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.fill,
              );
            }).toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(catModel.data!.data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: catModel!.data!.data!.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                    model.data!.products!.length,
                    (index) => InkWell(
                          child: buildGridProduct(
                              model.data!.products![index], context),onTap: (){
                            print( model.data!.products![index].id);
                            navigateTo(context, ProductDetailsScreen(model: model.data!.products![index]));
                    },
                        ))),
          )
        ]),
      );

  Widget buildGridProduct(ProductsModel model, context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(alignment: AlignmentDirectional.bottomStart, children: [
          Image(
            height: 180,
            image: NetworkImage(
              model.image!.toString(),
            ),
            width: double.infinity,
          ),
          if (model.discount != 0)
            Container(
              child: Text(
                'DISCOUNT',
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.red,
            ),
        ]),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  )),
              Row(
                children: [
                  Text('${model.price?.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text('${model.oldPrice?.round()}',
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
                        ShopLayoutCubit.get(context).changeFavorites(model.id!);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: backGroundButtonColor(model, context),
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
      ]);
}

Widget buildCategoryItem(DataModel dataModel) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(dataModel.image.toString()),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        Container(
          child: Text(
            dataModel.name.toString(),
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          width: 100,
          color: Colors.grey.shade900,
        )
      ],
    );

Color backGroundButtonColor(ProductsModel model, context) {
  if (ShopLayoutCubit.get(context).favorites[model.id] == true) {
    return Colors.blueAccent;
  } else {
    return defaultColor;
  }
}
