import 'package:flutter/material.dart';
import 'package:social_app1/modules/login/login_screen.dart';
import 'package:social_app1/modules/splash/splash_screen.dart';
import 'package:social_app1/shared/cache_helper/cache_helper.dart';
import 'package:social_app1/shared/components/widgets.dart';
import '../../shared/components/colors_style.dart';
import 'onboarding_model.dart';

void submit(BuildContext context) =>
    CacheHelper.setData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndReplacement(
          context,
          SplashScreen(
              screen: LoginScreen(), image: 'assets/images/splash2.png'),
        );
      }
    });

class BuildPageItem extends StatelessWidget {
  final OnBoardingModel model;

  const BuildPageItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Stack(
            children: [
              Container(
                height: 350,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: defaultGradient,
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(300)),
                  image: DecorationImage(
                    image: AssetImage(model.image),
                    //fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      //Navigate
                      submit(context);
                    },
                    child: const Text(
                      'SKIP',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SeaSandSun',
                          fontSize: 40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            model.title,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontFamily: 'SeaSandSun',
                  fontSize: 100,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            model.body,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}
