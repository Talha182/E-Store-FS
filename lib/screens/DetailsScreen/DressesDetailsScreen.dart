import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class DressesDetailsScreens extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;

  const DressesDetailsScreens(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description});
  @override
  State<DressesDetailsScreens> createState() => _DressesDetailsScreensState();
}

class _DressesDetailsScreensState extends State<DressesDetailsScreens> {
  String selectedSize = ''; // Initialize with an empty string or a default size

  // Add this line
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Blue Container - Positioned at the top half
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 2 + 30, // Specify your desired height
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage(widget.imageUrl), // Use the passed imageUrl
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            // handle button press
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // handle button press
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 30,
                      right: 1,
                      child: InkWell(
                        onTap: () {
                          // handle button press
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.favorite_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Second Container

          Positioned(
            top: screenHeight / 2 + 20, // Adjust this value to control overlap
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white, // Change the color as needed
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), // Curve for top left
                  topRight: Radius.circular(20), // Curve for top right
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.albertSans(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        Text(
                          widget.description,
                          style: GoogleFonts.albertSans(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
                                  unratedColor: Colors.grey.shade300,
                                  itemSize: 18,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (double value) {},
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "(320 reviews)",
                                  style: GoogleFonts.albertSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            Text(
                              "Available In Stock",
                              style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Size",
                          style: GoogleFonts.albertSans(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align items at the start vertically

                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children:
                                  ["S", "M", "L", "XL", "XXL"].map((size) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: CircularSizeButtons(
                                    size: size,
                                    isSelected: selectedSize == size,
                                    onPressed: () {
                                      setState(() {
                                        selectedSize = size;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                                width:
                                    20), // Spacing between size buttons and color picker
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 100,
                      right: 5,
                      child: Column(
                        children: [
                          ColorPicker(
                            colors: [
                              Colors.white,
                              Colors.black,
                              Colors.teal,
                              Colors.orange
                            ], // Example colors
                            onColorSelected: (Color color) {
                              // Handle color selection
                              print("Selected color: $color");
                            },
                          ),
                        ],
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

class CircularSizeButtons extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback onPressed;

  const CircularSizeButtons({
    Key? key,
    required this.size,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black.withOpacity(0.3)),
        ),
        child: Text(
          size,
          style: GoogleFonts.albertSans(
              color: isSelected ? Colors.white : Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onColorSelected;

  const ColorPicker({
    Key? key,
    required this.colors,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          child: Column(
            children: widget.colors.map((color) {
              bool isSelected = color == selectedColor;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                  widget.onColorSelected(color);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                  ),
                  child: isSelected
                      ? Icon(
                    Icons.check,
                    size: 16,
                    color: color == Colors.white ? Colors.black : Colors.white, // Change icon color based on background
                  )
                      : Container(), // Empty container for non-selected colors
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
