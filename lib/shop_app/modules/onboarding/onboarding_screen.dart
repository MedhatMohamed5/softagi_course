import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/shop_app/modules/login/shop_login_screen.dart';
import 'package:udemy_flutter/shop_app/shared/components/components.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';
import 'package:udemy_flutter/shop_app/shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({this.image, this.title, this.body});
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  final List<BoardingModel> list = [
    BoardingModel(
      image: 'assets/images/shop.png',
      title: 'Welcome',
      body: 'Hope you a good day',
    ),
    BoardingModel(
      image: 'assets/images/shop2.png',
      title: 'Our shop',
      body: 'Provides a good goods ;)',
    ),
    BoardingModel(
      image: 'assets/images/shop3.png',
      title: 'Let\'s start',
      body: 'Continue to see our services',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(
              'SKIP',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: () {
              _skipOrNavigate(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) => buildPageItem(list[index]),
                  itemCount: list.length,
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      isLast = index == list.length - 1;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: list.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      isLast ? 'Start' : 'Next',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      if (isLast) {
                        _skipOrNavigate(context);
                      } else {
                        controller.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _skipOrNavigate(BuildContext context) {
    ShopCacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateToReplacement(context, ShopLoginScreen());
      }
    });
  }

  Widget buildPageItem(BoardingModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
