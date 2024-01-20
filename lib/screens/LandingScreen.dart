import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginSignUp/LoginScreen.dart';
import 'LoginSignUp/SignUpScreen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
            image: AssetImage("assets/images/1.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1.0,
            sigmaY: 1.0,
          ),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(top: 170, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    radius: 70,
                  ),
                  // SizedBox(height: 20),
                  Spacer(),
                  SizedBox(
                      height: 50,
                      width: screenWidth - 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add login button functionality
                          Get.to(() => LoginScreen(),
                              transition: Transition.fade,
                              duration: const Duration(milliseconds: 200));                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          splashFactory: NoSplash.splashFactory,

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Login",
                            style: GoogleFonts.albertSans(color: Colors.black,fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 15,),
                  SizedBox(
                    height: 50,
                    width: screenWidth - 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 200));                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Colors.white, width: 2),
                        splashFactory: InkSplash.splashFactory,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.albertSans(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
