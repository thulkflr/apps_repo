import 'package:flutter/material.dart';
import 'package:project_flutter/Component/const_component.dart';
import 'package:project_flutter/Layout/Shop_App/Login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Network/Remote/shared_helper.dart';
import '../../../Styles/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingShow> boarding = [
    OnBoardingShow(
        image: 'Assets/Images/onBoard1.jpg', body: 'body1', title: 'title1'),
    OnBoardingShow(
        image: 'Assets/Images/onBoard2.jpg', body: 'body2', title: 'title2'),
    OnBoardingShow(
        image: 'Assets/Images/onBoard3.jpg', body: 'body3', title: 'title3')
  ];
  bool isLast = false;

  void submit() {
    Prefs.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) navigateAndReplacment(context, ShopLoginScreen());
    });
  }

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              controller: boardController,
              onPageChanged: (int index) {
                if (boarding.length - 1 == index) {
                  isLast = true;
                } else {
                  isLast = false;
                }
              },
            )),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                      activeDotColor: defaultColor),
                ),
                Spacer(flex: 12),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingShow show) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(show.image))),
          SizedBox(
            height: 30,
          ),
          Text(
            show.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          Text(
            show.body,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),

          //  PageView.builder(itemBuilder: itemBuilder)
        ],
      );
}

class OnBoardingShow {
  String image;
  String title;
  String body;

  OnBoardingShow(
      {required this.image, required this.title, required this.body});
}
