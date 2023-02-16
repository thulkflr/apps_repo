import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Component/const_component.dart';
import '../../../Layout/News_App/Cubit/cubit.dart';


class Ford_Screen extends StatelessWidget {
  const Ford_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).fords;

    return articleBuilder(list);
  }
}
