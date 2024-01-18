import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../screens/CartScreen.dart';
import '../screens/HomeScreen.dart';
import '../screens/NotificationScreen.dart';
import '../screens/ProfileScreen.dart';

class Navbar extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            CartScreen(),
            NotificationScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), // Adjust the radius as needed
              topRight: Radius.circular(15), // Adjust the radius as needed
            ),
          ),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  "Home",
                  style: GoogleFonts.lato(),
                ),
              ),

              /// Cart
              SalomonBottomBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text("Cart", style: GoogleFonts.lato()),
              ),

              /// Notifications
              SalomonBottomBarItem(
                icon: Icon(Icons.notifications),
                title: Text("Notifications", style: GoogleFonts.lato()),
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile", style: GoogleFonts.lato()),
              ),
            ],
          ),
        ));
  }
}
