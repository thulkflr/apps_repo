



import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../Layout/News_App/Cubit/cubit.dart';
import '../Layout/News_App/Cubit/states.dart';
import '../Layout/Shop_App/Login/login_screen.dart';
import '../Modules/News_App/Web_View/web_view.dart';
import '../Network/Remote/shared_helper.dart';

Widget buildArticleItems(article,context) => InkWell(
      onTap: () {
        navigateTo(
            context,
            WebViewScreen(
              url: article['url'],
            ));
      },
      child: Padding(
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItems(list[index],context),
              separatorBuilder: (context, index) => mySeparator(),
              itemCount: list.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
          condition: list.isNotEmpty,
        );
      },
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndReplacment(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false); //// why false?? : to cancel the previous page

void showToast({required String msg, required ToastStates states,context}) =>
    ToastView.createView(
        msg,
       context,
        Toast.lengthLong,
        Toast.bottom,
        chooseToastColor(states),
        const TextStyle(color: Colors.white, fontSize: 16),
        2,
        Border.symmetric(),
        false);

//enum
enum ToastStates { SUCCESS, ERORR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      {
        color = Colors.green;
      }
      break;
    case ToastStates.ERORR:
      {
        color = Colors.red;
      }
      break;
    case ToastStates.WARNING:
      {
        color = Colors.amber;
      }
      break;
  }
  return color;
}
void signOut(context)
{
  Prefs.removeDATA('token').then((value) {
    if(value)
    {
      navigateAndReplacment(context, ShopLoginScreen());
    }
  });
}
String token ='';//fromMain