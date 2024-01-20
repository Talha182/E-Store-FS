import 'package:e_commerce/Custom_Widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Add a boolean to track email validity
  final _validateEmail = ValueNotifier<bool>(false);

  // Email validation using regular expression
  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }


  Future<void> registerUser() async {
    // Trigger email validation
    _validateEmail.value = true;

    final String userName = userNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    if (userName.isEmpty || email.isEmpty || password.isEmpty ) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }
    if (!isEmailValid(email)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return; // Stop the registration process if email is invalid
    }

    // API request to register user
    const String url = 'http://10.0.2.2:3000/register'; // Replace with your actual API endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': userName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'User registered successfully');
        clearText(); // Clear the text fields only on successful registration
        Get.to(() => Navbar()); // Navigate to the next screen
      } else if (response.statusCode == 409) {
        final responseBody = json.decode(response.body);
        Get.snackbar('Error', responseBody['error']);
        // Do not clear text fields here, as registration was not successful
      } else {
        Get.snackbar('Error', 'Failed to register user');
        // Do not clear text fields here either
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      // Do not clear text fields in case of an error
    }
  }

  void clearText() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
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
                "Sign Up",
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Create a new account",
                style: GoogleFonts.albertSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.5)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "User Name",
                style: GoogleFonts.albertSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              TextField(
                controller: userNameController,
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
                "Email",
                style: GoogleFonts.albertSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              TextField(
                controller: emailController,
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
                  errorText: _validateEmail.value && !isEmailValid(emailController.text) ? 'Please enter a valid email address' : null,

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
                controller: passwordController,
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

              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: screenWidth - 60,
                child:   ElevatedButton(
                  onPressed: () {
                    registerUser();
                    // Do not clear text if there's an error
                    if (isEmailValid(emailController.text)) {
                      clearText();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "SignUp",
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
    );
  }
}
