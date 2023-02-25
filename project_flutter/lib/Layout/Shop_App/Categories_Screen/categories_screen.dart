// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../Component/const_component.dart';
//
// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  ListView.separated(itemBuilder: (context,index)=>buildCatItem(), separatorBuilder: (context,index)=>mySeparator(), itemCount: 10);
//   }
//   Widget buildCatItem()=>Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image(
//           image: NetworkImage(
//               'https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg'),
//           width: 120,
//           height: 120,
//           fit: BoxFit.cover,
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         Text(
//           'data',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ), Spacer(),Icon(Icons.arrow_forward_ios)
//       ],
//     ),
//   );
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/cubit.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/states.dart';
import 'package:project_flutter/Models/Shop_App/categories_model.dart';

import '../../../Component/const_component.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopStates>(
      listener: (context, state) {

      },builder: (context, state) {
      return  ListView.separated(physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCatItem(ShopLayoutCubit.get(context).categoriesModel.data!.data![index]),
          separatorBuilder: (context, index) => mySeparator(),
          itemCount: ShopLayoutCubit.get(context).categoriesModel.data!.data!.length);
    },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: NetworkImage(
              model.image.toString()),
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
