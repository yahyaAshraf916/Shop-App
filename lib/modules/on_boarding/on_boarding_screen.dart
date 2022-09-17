import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreeen extends StatefulWidget {
  @override
  State<OnBoardingScreeen> createState() => _OnBoardingScreeenState();
}

class _OnBoardingScreeenState extends State<OnBoardingScreeen> {
  var boardcontroller = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      "assets/images/onboard_1.jpg",
      "Strain Less Groceries",
      "Select cheap and best products from a wide variety of groceries in Salla stores",
    ),
    BoardingModel(
      "assets/images/onboard_2.jpg",
      "Touch to order",
      "Add your favorite items in the cart and place an order to get your groceries",
    ),
    BoardingModel(
      "assets/images/onboard_3.jpg",
      "Rapid delivery at doorstep",
      "Guaranteed swift delivery at your doorstep and you can also delivery option",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: () {
                submit(context);
              },
              text: "SKIP")
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardcontroller,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildboardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                      activeDotColor: defaultcolor),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      setState(() {
                        submit(context);
                      });
                    } else {
                      boardcontroller.nextPage(
                        duration: Duration(microseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildboardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
void submit(context) {
  CachHelper.saveData(key: "onBoarding", value: true).then((value) {
   if(value==true){
    navigateAndFinish(context, ShopLoginScreen());
   }
  }) ;
  
}
