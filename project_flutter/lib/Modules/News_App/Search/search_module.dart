import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Component/const_component.dart';
import 'package:project_flutter/Layout/News_App/Cubit/cubit.dart';
import 'package:project_flutter/Layout/News_App/Cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchKey = TextEditingController();
    final formKey = GlobalKey<FormState>();

    var list = NewsCubit.get(context).searches;

    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: searchKey,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('search must not be empty');
                        }

                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Search',
                      ),
                      onChanged: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                    ),
                  ),
                ),
                articleBuilder(list)
              ],
            ),
          );
        },
      ),
    );
  }
}
