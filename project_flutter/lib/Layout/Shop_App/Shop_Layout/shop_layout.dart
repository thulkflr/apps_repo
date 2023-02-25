import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Component/const_component.dart';

import 'package:project_flutter/Layout/Shop_App/Search_Screen/search_screen.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/cubit.dart';
import 'package:project_flutter/Layout/Shop_App/Shop_Layout/Cubit/states.dart';
 class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<ShopLayoutCubit,ShopStates>(
      listener: (context, state) {
 
      },
      builder: (context, state) {
        var cubit= ShopLayoutCubit.get(context);

        return Scaffold(
        appBar: AppBar(title: Text('Salla'),actions: [IconButton(onPressed: (){
          navigateTo(context, SearchScreen());
        }, icon: const Icon(Icons.search))],
        ),
        body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.bottomChange(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
      );}
    );
  }
}
