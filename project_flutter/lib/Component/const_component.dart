import 'dart:js';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Layout/News_App/Cubit/cubit.dart';
import '../Layout/News_App/Cubit/states.dart';
import '../Modules/News_App/Web_View/web_view.dart';

Widget buildArticleItems(article) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(url: article['url'],));
  },
  child:   Padding(
  
        padding: const EdgeInsets.all(8.0),
  
        child: Row(
  
          children: [
  
            Container(
  
              height: 120,
  
              width: 120,
  
              decoration: BoxDecoration(
  
                  borderRadius: BorderRadius.circular(10.2),
  
                  image: DecorationImage(
  
                      image: NetworkImage('${article['urlToImage']}'),
  
                      fit: BoxFit.fill)),
  
            ),
  
            SizedBox(
  
              width: 20,
  
            ),
  
            Expanded(
  
              child: Container(
  
                height: 120,
  
                child: Column(
  
                  mainAxisAlignment: MainAxisAlignment.start,
  
                  crossAxisAlignment: CrossAxisAlignment.start,
  
                  children: [
  
                    Expanded(
  
                      child: Text(
  
                        '${article['title']}',
  
                        style:
  
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  
                        maxLines: 3,
  
                        overflow: TextOverflow.ellipsis,
  
                      ),
  
                    ),
  
                    Text(
  
                      '${article['publishedAt']}',
  
                      style: TextStyle(
  
                          fontSize: 14,
  
                          fontWeight: FontWeight.w300,
  
                          color: Colors.grey),
  
                    ),
  
                  ],
  
                ),
  
              ),
  
            )
  
          ],
  
        ),
  
      ),
);

Widget mySeparator() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: const Divider(
        height: 10,
        thickness: 1,
        indent: 5,
        endIndent: 5.0,
        color: Colors.grey,
      ),
    ));

Widget articleBuilder(List list) => BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (context) => ListView.separated(
              physics:   BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItems(list[index]),
              separatorBuilder: (context, index) => mySeparator(),
              itemCount: list.length),
          fallback: (context) =>   Center(child: CircularProgressIndicator()),
          condition: list.isNotEmpty,
        );
      },
    );

void navigateTo(context, widget) =>
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => widget));
