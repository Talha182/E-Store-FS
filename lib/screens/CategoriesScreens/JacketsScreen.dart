import 'package:e_commerce/screens/DetailsScreen/JacketsDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';

class JacketsScreen extends StatefulWidget {
  const JacketsScreen({Key? key}) : super(key: key);

  @override
  _JacketsScreenState createState() => _JacketsScreenState();
}

class _JacketsScreenState extends State<JacketsScreen> {
  late Future<List<dynamic>> _jacketsFuture;

  @override
  void initState() {
    super.initState();
    _jacketsFuture = ApiService().getJackets(); // Fetch Jackets data asynchronously
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _jacketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No Jackets found'));
          } else {
            return _buildJacketsList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildJacketsList(List<dynamic> jackets) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: (jackets.length + 1) ~/ 2, // Adjust count for grid-like layout
      itemBuilder: (context, pairIndex) {
        int leftIndex = pairIndex * 2;
        int rightIndex = leftIndex + 1;
        bool isRightItemPresent = rightIndex < jackets.length;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: JacketsItem(jackets: jackets[leftIndex]),
            ),
            Expanded(
              child: isRightItemPresent
                  ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: JacketsItem(jackets: jackets[rightIndex]),
              )
                  : Container(), // Empty container to maintain alignment
            ),
          ],
        );
      },
    );
  }
}

class JacketsItem extends StatefulWidget {
  final Map<String, dynamic> jackets;

  const JacketsItem({
    Key? key,
    required this.jackets,
  }) : super(key: key);

  @override
  State<JacketsItem> createState() => _JacketsItemState();
}

class _JacketsItemState extends State<JacketsItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Default values for potentially null fields
    String name = widget.jackets['name'] ?? 'Unknown Name';
    String description = widget.jackets['description'] ?? 'No description';
    String price = widget.jackets['price'] ?? 'N/A';
    String imageUrl = widget.jackets['image'] ?? 'https://via.placeholder.com/160';

    return Column(
      children: [
        _buildImage(imageUrl,name, description, price),
        _buildInfo(name, description, price),
      ],
    );
  }

  Widget _buildImage(String imageUrl, String title, String description, String price) {
    return InkWell(
      onTap: (){
        Get.to(() => JacketsDetailsScreens(imageUrl: imageUrl, title: title, description: description, price: price));
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
        child:  Align(
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
          Text(name, style: GoogleFonts.albertSans(fontWeight: FontWeight.bold)),
          Text(description),
          Text(price, style: GoogleFonts.albertSans(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
