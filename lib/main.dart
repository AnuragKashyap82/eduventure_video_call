import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
// import 'package:window_manager/window_manager.dart';
import 'constants/colors.dart';
import 'firebase_options.dart';
import 'navigator_key.dart';
import 'screens/common/splash_screen.dart';

void main() async {
  // Run Flutter App
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material App
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      title: 'VideoSDK Flutter Example',
      theme: ThemeData(
          fontFamily: "SegSemiBold",
          useMaterial3: true,
          indicatorColor: colorPrimary,
          textSelectionTheme:  TextSelectionThemeData(
              cursorColor: colorPrimary,
              selectionColor: colorPrimary,
              selectionHandleColor: colorPrimary),
          appBarTheme:  AppBarTheme(
            surfaceTintColor: colorPrimary,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: colorPrimary,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
            ),
          )),
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
