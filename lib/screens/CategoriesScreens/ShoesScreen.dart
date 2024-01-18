import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';

class ShoesScreen extends StatefulWidget {
  const ShoesScreen({Key? key}) : super(key: key);

  @override
  _ShoesScreenState createState() => _ShoesScreenState();
}

class _ShoesScreenState extends State<ShoesScreen> {
  late Future<List<dynamic>> _shoesFuture;

  @override
  void initState() {
    super.initState();
    _shoesFuture = ApiService().getShoes(); // Fetch Jeans data asynchronously
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _shoesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No Shoes found'));
          } else {
            return _buildShoesList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildShoesList(List<dynamic> shoes) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: (shoes.length + 1) ~/ 2, // Adjust count for grid-like layout
      itemBuilder: (context, pairIndex) {
        int leftIndex = pairIndex * 2;
        int rightIndex = leftIndex + 1;
        bool isRightItemPresent = rightIndex < shoes.length;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ShoesItem(dress: shoes[leftIndex]),
            ),
            Expanded(
              child: isRightItemPresent
                  ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ShoesItem(dress: shoes[rightIndex]),
              )
                  : Container(), // Empty container to maintain alignment
            ),
          ],
        );
      },
    );
  }
}

class ShoesItem extends StatelessWidget {
  final Map<String, dynamic> dress;

  const ShoesItem({
    Key? key,
    required this.dress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default values for potentially null fields
    String name = dress['name'] ?? 'Unknown Name';
    String description = dress['description'] ?? 'No description';
    String price = dress['price'] ?? 'N/A';
    String imageUrl = dress['image'] ?? 'https://via.placeholder.com/160';

    return Column(
      children: [
        _buildImage(imageUrl),
        _buildInfo(name, description, price),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    return Container(
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
      child: const Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: null,
          icon: Icon(Icons.favorite_outline),
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
