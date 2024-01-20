import 'package:e_commerce/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartModel>(
          create: (context) {
            CartModel cartModel = CartModel();
            cartModel.fetchCartItems(); // Fetch cart items when the app starts
            return cartModel;
          },
        ),
        ChangeNotifierProvider<WishlistModel>(
          create: (context) {
            WishlistModel wishlistModel = WishlistModel();
            wishlistModel.fetchWishlistItems(); // Fetch wishlist items when the app starts
            return wishlistModel;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}
