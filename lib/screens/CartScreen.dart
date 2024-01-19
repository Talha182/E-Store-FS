import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../services/api_service.dart'; // Import ApiService

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, cartModel, child) {
                return cartModel.items.isEmpty
                    ? Center(child: Text('No items in the cart'))
                    : ListView.builder(
                  itemCount: cartModel.items.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(item: cartModel.items[index]);
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Proceed to Checkout'),
              onPressed: () {
                // TODO: Add your checkout logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}


class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Padding(
            padding: EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 20),
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
                          borderRadius: BorderRadius.circular(
                              20), // This line adds the border radius to the image
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
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title,
                              style: GoogleFonts.albertSans(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            'Size: ${item.selectedSize}',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.4)),
                          ),
                          Text(
                            'Quantity: ${item.quantity}',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.4)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${item.price}',
                      style: GoogleFonts.albertSans(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

