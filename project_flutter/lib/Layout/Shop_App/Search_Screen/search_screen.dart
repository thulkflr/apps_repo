import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Search_Screen/Cubit/cubit.dart';
import 'package:project_flutter/Layout/Shop_App/Search_Screen/Cubit/states.dart';

import '../../../Component/const_component.dart';
import '../../../Styles/colors.dart';

import '../Shop_Layout/Cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: TextFormField(
                        controller: searchController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          SearchCubit.get(context).search(value);
                        },
                        autofocus: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Search',
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            )),
                        validator: (value) => value!.isEmpty
                            ? 'Search Bar can\'t be empty'
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildSearchItem(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data!
                                    .data![index],
                                context),
                            separatorBuilder: (context, index) => mySeparator(),
                            itemCount: SearchCubit.get(context)
                                .searchModel
                                .data!
                                .data!
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchItem(dataModel, context, {bool isSearch = false}) => Padding(
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
                  '${dataModel.image}',
                ),
                width: double.infinity,
              ),
              if (dataModel.discount != 0 && isSearch)
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
                Text(dataModel.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                    )),
                Spacer(),
                Row(
                  children: [
                    Text('${dataModel.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    SizedBox(
                      width: 5,
                    ),
                    if (dataModel.discount != 0 && isSearch)
                      Text('${dataModel.oldPrice}',
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
                              .changeFavorites(dataModel.id!);

                          //  print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              backGroundButtonColor(dataModel, context),
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

Color backGroundButtonColor(model, context) {
  if (ShopLayoutCubit.get(context).favorites[model.id!] == true) {
    return Colors.blueAccent;
  } else {
    return defaultColor;
  }
}
