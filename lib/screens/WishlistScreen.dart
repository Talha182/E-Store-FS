import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
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
                      onAddToCart: () async {
                        // Add to Cart Functionality
                        await addToCart(item);
                      },
                    );
                  },
                );
        },
      ),
    );
  }

  Future<void> addToCart(WishlistItem item) async {
    final apiService = ApiService();
    try {
      // Set a default size or modify to allow size selection
      String defaultSize = "M"; // Example default size

      await apiService.addCartItem({
        'imageUrl': item.imageUrl,
        'title': item.title,
        'price': item.price,
        'selectedSize': defaultSize, // Use the default size
        'quantity': 1,
      });

      // Fetch updated cart items
      Provider.of<CartModel>(context, listen: false).fetchCartItems();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.title} added to cart')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding to cart')),
      );
    }
  }
}

class WishlistItemWidget extends StatelessWidget {
  final WishlistItem item;
  final VoidCallback onDelete;
  final VoidCallback onAddToCart; // New callback for adding to cart

  const WishlistItemWidget(
      {Key? key,
      required this.item,
      required this.onDelete,
      required this.onAddToCart // Initialize onAddToCart
      })
      : super(key: key);

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
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 20),
              child: Stack(
                children: [
                  Row(
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
                                  '${item.description}',
                                  style: GoogleFonts.albertSans(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.price,
                                        style: GoogleFonts.albertSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 5,
                      right: 1,
                      child: SizedBox(
                        height: 35,
                        width: 110,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          onPressed: () {
                            onAddToCart();
                          },
                          child: Text(
                            "Add to cart",
                            style: GoogleFonts.albertSans(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
