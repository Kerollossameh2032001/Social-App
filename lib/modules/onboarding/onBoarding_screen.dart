import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app1/shared/components/colors_style.dart';
import '../../shared/components/icon_broken.dart';
import 'onboarding_components.dart';
import 'onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: pagesContents.length,
              itemBuilder: (context, index) =>
                  BuildPageItem(model: pagesContents[index]),
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                if (index == pagesContents.length - 1) {
                  setState(() => isLast = true);
                } else {
                  setState(() => isLast = false);
                }
              },
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: pagesContents.length,
            effect: const WormEffect(
              activeDotColor: defaultColor,
              dotHeight: 10,
              dotWidth: 10,
              type: WormType.normal,
              strokeWidth: 5,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: defaultGradient,
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (isLast == false) {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      } else {
                        //Navigate
                        submit(context);
                      }
                    },
                    icon: const Icon(
                      IconBroken.Arrow___Right_2,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
