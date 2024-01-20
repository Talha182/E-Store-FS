import 'package:e_commerce/screens/DetailsScreen/DressesDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';

class DressesScreen extends StatefulWidget {
  const DressesScreen({Key? key}) : super(key: key);

  @override
  _DressesScreenState createState() => _DressesScreenState();
}

class _DressesScreenState extends State<DressesScreen> {
  late Future<List<dynamic>> _dressesFuture;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _dressesFuture =
        ApiService().getDresses(); // Fetch dresses data asynchronously
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _dressesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No dresses found'));
          } else {
            return _buildDressesList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildDressesList(List<dynamic> dresses) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: (dresses.length + 1) ~/ 2, // Adjust count for grid-like layout
      itemBuilder: (context, pairIndex) {
        int leftIndex = pairIndex * 2;
        int rightIndex = leftIndex + 1;
        bool isRightItemPresent = rightIndex < dresses.length;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DressItem(dress: dresses[leftIndex]),
            ),
            Expanded(
              child: isRightItemPresent
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DressItem(dress: dresses[rightIndex]),
                    )
                  : Container(), // Empty container to maintain alignment
            ),
          ],
        );
      },
    );
  }
}

class DressItem extends StatefulWidget {
  final Map<String, dynamic> dress;

  const DressItem({
    Key? key,
    required this.dress,
  }) : super(key: key);

  @override
  State<DressItem> createState() => _DressItemState();
}

class _DressItemState extends State<DressItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Default values for potentially null fields
    String name = widget.dress['name'] ?? 'Unknown Name';
    String description = widget.dress['description'] ?? 'No description';
    String price = widget.dress['price'] ?? 'N/A';
    String imageUrl =
        widget.dress['image'] ?? 'https://via.placeholder.com/160';

    return Column(
      children: [
        _buildImage(imageUrl, name, description, price),
        _buildInfo(name, description, price),
      ],
    );
  }

  Widget _buildImage(
      String imageUrl, String name, String description, String price) {
    return InkWell(
      onTap: () {
        Get.to(() => DressesDetailsScreens(
              imageUrl: imageUrl,
              title: name,
              description: description,
              price: price,
            ));
      },
      child: Container(
        width: 160,
        height: 180,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite; // Toggle the favorite state
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color:
                  isFavorite ? Colors.red : Colors.black, // Toggle icon color
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String name, String description, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name,
              style: GoogleFonts.albertSans(fontWeight: FontWeight.bold)),
          Text(description),
          Text(price,
              style: GoogleFonts.albertSans(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
