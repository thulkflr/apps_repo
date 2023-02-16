import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_flutter/Component/const_component.dart';
import 'package:project_flutter/Layout/News_App/Cubit/cubit.dart';
import 'package:project_flutter/Layout/News_App/Cubit/states.dart';

class Tesla_Screen extends StatelessWidget {
  const Tesla_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).teslas;

    return articleBuilder(list);
  }
}
