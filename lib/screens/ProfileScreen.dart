import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the size of the screen
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // First container
          Container(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.logout))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(
                          image: AssetImage("assets/images/pfp.jpg"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Alexander George",
                    style: GoogleFonts.albertSans(
                        fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  Text(
                    "@username",
                    style: GoogleFonts.albertSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.black.withOpacity(0.5)),
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    ),
                    child: Text('Edit Profile',
                        style: GoogleFonts.albertSans(
                            color: Colors.black, fontSize: 15)),
                  )
                ],
              ),
            ),
          ),
          // Positioned second container
          Positioned(
            top: screenSize.height / 2, // Adjust this value if needed
            left: 0,
            right: 0,
            child: Container(
              height:
                  screenSize.height / 2 + 40, // Adding extra height for overlap
              decoration: const BoxDecoration(
                color: Colors
                    .white, // Ensure this color blends well with Scaffold's background

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              // Add content to this container
              child: Padding(
                padding: EdgeInsets.only(top: 45, left: 15, right: 15),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(0.1)),
                                  child: Icon(
                                    Icons.settings_outlined,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Settings",
                                  style: GoogleFonts.albertSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(0.1)),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Change Password",
                                  style: GoogleFonts.albertSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(0.1)),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Invite Friends",
                                  style: GoogleFonts.albertSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
