import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/layout/layout_screen.dart';
import 'package:social_app1/models/notification_model.dart';
import 'package:social_app1/modules/login/login_screen.dart';
import 'package:social_app1/modules/splash/splash_screen.dart';
import 'package:social_app1/shared/bloc_observer/bloc_observer.dart';
import 'package:social_app1/shared/cache_helper/cache_helper.dart';
import 'package:social_app1/shared/components/constant.dart';
import 'package:social_app1/shared/components/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app1/shared/dio_helper/dio_helper.dart';
import 'modules/onboarding/onBoarding_screen.dart';

Widget chooseStartScreen(String? uId, bool? onBoarding) {
  Widget screen;
  if (onBoarding == null || onBoarding == false) {
    screen = SplashScreen(
        screen: OnBoardingScreen(), image: 'assets/images/splash1.png');
  } else {
    if (uId == null) {
      screen = SplashScreen(
          screen: LoginScreen(), image: 'assets/images/splash2.png');
    } else {
      savedUId = uId;
      screen = const SplashScreen(
          screen: LayoutScreen(), image: 'assets/images/splash1.png');
    }
  }
  return screen;
}

ThemeMode appMode() {
  if (CacheHelper.getData(key: 'isDark') == null) {
    return ThemeMode.system;
  } else {
    if (CacheHelper.getData(key: 'isDark')) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationModel model = NotificationModel(
    uId: message.data["uId"],
    body: message.data["body"],
    dateTime: message.data["dateTime"],
  );
  count++;
  currentNotifications.add(model);
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  var token = await FirebaseMessaging.instance.getToken();

  print("the device token is : $token ");


  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  ThemeMode? mode = appMode();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
      ],
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Social App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: chooseStartScreen(CacheHelper.getData(key: 'uId'),
                CacheHelper.getData(key: 'onBoarding')),
            //isDark ? ThemeMode.dark : ThemeMode.light,
            themeMode: appMode(),
          );
        },
      ),
    );
  }
}
