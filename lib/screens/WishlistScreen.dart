import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/wishlist_model.dart'; // Import WishlistModel
import '../services/api_service.dart'; // Import ApiService

// WishlistScreen
class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch wishlist items when the screen is initialized
    final wishlistModel = Provider.of<WishlistModel>(context, listen: false);
    wishlistModel.fetchWishlistItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Consumer<WishlistModel>(
        builder: (context, wishlistModel, child) {
          return wishlistModel.items.isEmpty
              ? const Center(child: Text('No items in the wishlist'))
              : ListView.builder(
            itemCount: wishlistModel.items.length,
            itemBuilder: (context, index) {
              final item = wishlistModel.items[index];
              return WishlistItemWidget(
                item: item,
                onDelete: () async {
                  try {
                    await wishlistModel.deleteItem(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.title} removed from wishlist'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error removing item'),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

// WishlistItemWidget
class WishlistItemWidget extends StatelessWidget {
  final WishlistItem item;
  final VoidCallback onDelete;

  const WishlistItemWidget({Key? key, required this.item, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 12),
      child: Dismissible(
        key: Key(item.id), // Assuming each item has a unique 'id'
        direction: DismissDirection.endToStart, // Swipe from right to left
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
        ),
        onDismissed: (direction) {
          onDelete();
        },
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Material(
                        elevation: 1.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: double.infinity,
                          width: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              item.imageUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title,
                                style: GoogleFonts.albertSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              'Size: ${item.selectedSize}',
                              style: GoogleFonts.albertSans(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
