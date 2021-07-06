import 'package:flutter/material.dart';
import 'package:news_app/components/component.dart';
import 'package:news_app/shopApp/login/shop_login_screen.dart';
import 'package:news_app/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel(
      {@required this.image, @required this.title, @required this.body});
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'asset/images/onboard1.png',
        title: 'On Board1 Title',
        body: 'On Board1 body'),
    BoardingModel(
        image: 'asset/images/onboard1.png',
        title: 'On Board2 Title',
        body: 'On Board2 body'),
    BoardingModel(
        image: 'asset/images/onboard1.png',
        title: 'On Board3 Title',
        body: 'On Board3 body')
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(function:() {
                  navigateAndFinish(context, ShopLoginScreen());
                } ,
             text: 'Skip'),
            
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                      onPageChanged: (int index) {
                        if (index == boarding.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                          print('last');
                        } else {
                          print(' Not last');
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                      controller: boardController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildBoardingItem(boarding[index]),
                      itemCount: boarding.length)),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 5,
                          activeDotColor: defaultColor),
                      count: boarding.length),
                  SizedBox(
                    height: 30,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        navigateAndFinish(context, ShopLoginScreen());
                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage('${model.image}'))),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
