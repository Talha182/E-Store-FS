import 'package:e_commerce/screens/LoginSignUp/SignUpScreen.dart';
import 'package:e_commerce/Custom_Widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> loginUser() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      // Handle the response here
      if (response.statusCode == 200) {
        Get.to(() => Navbar());
      } else {
        final responseBody = json.decode(response.body);
        Get.snackbar('Error', responseBody['error'] ?? 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
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
            SizedBox(height: 20),
            Text(
              "Welcome!",
              style: GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              "Please login or sign up to continue our app",
              style: GoogleFonts.albertSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.black.withOpacity(0.5)),
            ),
            SizedBox(height: 40),
            Text(
              "Email",
              style: GoogleFonts.albertSans(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Password",
              style: GoogleFonts.albertSans(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: screenWidth - 60,
              child: ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Login",
                    style: GoogleFonts.albertSans(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () => Get.to(() => SignUpScreen()),
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
