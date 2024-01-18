import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:e_commerce/screens/CategoriesScreens/DressesScreen.dart';
import 'package:e_commerce/screens/CategoriesScreens/JacketsScreen.dart';
import 'package:e_commerce/screens/CategoriesScreens/JeansScreen.dart';
import 'package:e_commerce/screens/CategoriesScreens/ShoesScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchBarVisible = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Icon(Icons.menu_rounded, color: Colors.white),
                    ),
                  ),
                  InkWell(
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage("assets/images/pfp.jpg"),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 280,
                    child: SearchBarAnimation(
                      textEditingController: TextEditingController(),
                      isOriginalAnimation: true,
                      durationInMilliSeconds: 300,
                      enableKeyboardFocus: true,
                      trailingWidget: const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      secondaryButtonWidget: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      ),
                      buttonWidget: const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Icon(Icons.category, color: Colors.white),
                    ),
                  ),
                ],
              ),
              HomeButtonsTabBar(),

              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    DressesScreen(),
                    JacketsScreen(),
                    JeansScreen(),
                    ShoesScreen()
                  ],
                ),
              ) //
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButtonsTabBar extends StatelessWidget {
  const HomeButtonsTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      backgroundColor: Colors.black, // Unselected tab background
      unselectedBackgroundColor:
          Colors.transparent, // Transparent for unselected tab
      borderWidth: 1,
      borderColor: Colors.grey, // Grey border for each tab
      unselectedBorderColor:
          Colors.grey, // Grey border for unselected tabs
      labelStyle: GoogleFonts.roboto(
        color: Colors.white, // White text color for selected tab
        fontWeight: FontWeight.w500
      ),
      unselectedLabelStyle: GoogleFonts.roboto(
        color: Colors.black, // Black text color for unselected tab
        fontWeight: FontWeight.w500
      ),
      radius: 20, // Circle radius for each tab
      // Add your tabs here
      tabs: [
        Tab(
          text: "Dresses",
        ),
        Tab(
          text: "Jackets",
        ),
        Tab(
          text: "Jeans",
        ),
        Tab(
          text: "Shoes",
        ),
      ],
    );
  }
}
