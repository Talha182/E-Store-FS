import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios), color: Colors.black, iconSize: 20,),
                Expanded(
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.albertSans(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: IconButton(onPressed: null, icon: Icon(Icons.arrow_back_ios)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
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
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 10,
                    child: InkWell(
                      onTap: (){},
                      child: Container(
                        child: Icon(Icons.camera_alt,color: Colors.white,),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,top: 40,),
              child: Text("Full name",style: GoogleFonts.albertSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.6),
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),  Padding(
              padding: EdgeInsets.only(left: 10,top: 40,),
              child: Text("Email Address",style: GoogleFonts.albertSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.6),
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),  Padding(
              padding: EdgeInsets.only(left: 10,top: 40,),
              child: Text("Username",style: GoogleFonts.albertSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.6),
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
