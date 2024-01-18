import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 70,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome!",
              style:
              GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please login or sign up to continue our app",
              style: GoogleFonts.albertSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.black.withOpacity(0.5)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Email",
              style: GoogleFonts.albertSans(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300, // Color when focused
                    width: 1.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // Color when focused
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Password",
              style: GoogleFonts.albertSans(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300, // Color when focused
                    width: 1.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, // Color when focused
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: screenWidth - 60,
              child: ElevatedButton(
                onPressed: () {
                  // Add login button functionality
                  Get.to(() => const LoginScreen(),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 200));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Login",
                    style: GoogleFonts.albertSans(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {},
                  child: Text("Sign Up"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
