// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:project_flutter/Layout/Shop_App/Login/login_screen.dart';
// import 'package:project_flutter/Layout/Shop_App/Shop_Layout/shop_layout.dart';
// import 'package:project_flutter/Models/Shop_App/home_model.dart';
//
// import '../../Network/Remote/shared_helper.dart';
//
//
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedSplashScreen.withScreenFunction(
//         splash: 'assets/images/logo.png',
//         splashIconSize: 150,
//         screenFunction: () async {
//           var data = Prefs.saveData( key: 'token',value: true) ?? '';
//           var loginState = Prefs.getBooleanValue('loginState') ?? false;
//           if (loginState) {
//             var home = await getHomeData(data);
//             return ShopLayout();
//           } else {
//             return ShopLoginScreen();
//           }
//         },
//       ),
//     );
//   }
//
//   Future<HomeModelData?> getHomeData(var data ) async {
//     final HomeModel homeModelData = HomeModel( );
//     return await homeModelData.data;
//   }
// }