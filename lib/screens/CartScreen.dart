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
  void initState() {
    super.initState();
    // Fetch cart items when the screen is initialized
    final cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.fetchCartItems();
  }



  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, cartModel, child) {
                return cartModel.items.isEmpty
                    ? const Center(child: Text('No items in the cart'))
                    : ListView.builder(
                        itemCount: cartModel.items.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(item: cartModel.items[index]);
                        },
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SubTotal:',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('\$${cartModel.getTotalAmount()}',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping:',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('\$${cartModel.getShippingAmount()}',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('BagTotal:',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(
                            '(${cartModel.items.length} items) \$${cartModel.getFinalAmount()}',
                            style: GoogleFonts.albertSans(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.black,
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Text('Proceed to Checkout',
                    style: GoogleFonts.albertSans(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                onPressed: () {
                  // TODO: Add your checkout logic here
                },
              ),
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
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 12),
        child: Dismissible(
          key: Key(item.id), // Assuming each item has a unique 'id'
          direction: DismissDirection.endToStart, // Swipe from right to left
          background: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20)
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
          onDismissed: (direction) async {
            try {
              await Provider.of<CartModel>(context, listen: false)
                  .deleteItem(item.id); // Add deleteItem method in CartModel
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Item removed from cart'),
              ));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error removing item'),
              ));
            }
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
                padding:
                    const EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 20),
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
        ));
  }
}
