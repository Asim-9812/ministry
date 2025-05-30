


import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: MyColors.white,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
          useMaterial3: true,
        ),
        home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(0.9)),
            child: SplashScreen()
        ),
      ),
    );
  }
}
