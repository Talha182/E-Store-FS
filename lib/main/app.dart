import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:e_commerce/Custom_Widgets/Navbar.dart';
import 'package:e_commerce/notifcation_controller.dart';
import 'package:e_commerce/screens/EditProfileScreen.dart';
import 'package:e_commerce/screens/LandingScreen.dart';
import 'package:e_commerce/screens/LoginSignUp/LoginScreen.dart';
import 'package:e_commerce/screens/LoginSignUp/SignUpScreen.dart';
import 'package:e_commerce/screens/PaymentScreen.dart';
import 'package:e_commerce/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod

    );
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      home: LoginScreen(),
    );
  }
}
