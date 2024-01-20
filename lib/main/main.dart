import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        CartModel cartModel = CartModel();
        cartModel.fetchCartItems(); // Fetch cart items when the app starts
        return cartModel;
      },
      child: const MyApp(),
    ),
  );
}
