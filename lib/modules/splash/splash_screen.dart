import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../shared/components/colors_style.dart';


class SplashScreen extends StatelessWidget {
  final Widget screen;
  final String image;

  const SplashScreen({Key? key, required this.screen, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: EasySplashScreen(
              logo: Image.asset(image),
              //backgroundImage: ,
              gradientBackground: defaultGradient,
              logoWidth: 200,
              durationInSeconds: 2,
              navigator: screen,
              showLoader: true,
              loaderColor: defaultColor,
              loadingText: Text(
                "Loading ....",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white, fontFamily: 'SeaSandSun',fontSize: 100),
              ),
              loadingTextPadding: EdgeInsets.all(8.0),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              color: defaultColor,
            ),
          ),
        ],
      ),
    );
  }
}
