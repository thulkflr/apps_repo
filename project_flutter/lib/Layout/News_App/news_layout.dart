import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Component/const_component.dart';
import 'package:project_flutter/Cubit/cubit.dart';
import 'package:project_flutter/Layout/News_App/Cubit/cubit.dart';
import 'package:project_flutter/Layout/News_App/Cubit/states.dart';

import 'package:project_flutter/Network/Remote/dio_helper.dart';

import '../../Modules/News_App/Search/search_module.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('News Paper'),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search,)),
              IconButton(onPressed: () {
                CounterCubit.get(context).changeAppTheme();
              }, icon: Icon(Icons.brightness_4_outlined,)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {


            },
            child: Icon(Icons.add),
          ),
          body: NewsCubit.get(context)
              .Screens[NewsCubit.get(context).current_index],
          bottomNavigationBar: BottomNavigationBar(
            items: NewsCubit.get(context).items,
            currentIndex: NewsCubit.get(context).current_index,
            onTap: (index) {
              NewsCubit.get(context).changeBottomNavBar(index);
            },
          ),
        );
      },
      listener: (BuildContext context, state) {},
    );
  }
}
