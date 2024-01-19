import 'package:flutter/material.dart';

import '../services/api_service.dart';

class CartItem {
  final String imageUrl;
  final String title;
  final String price;
  final String selectedSize;
  final int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.selectedSize,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      imageUrl: json['imageUrl'],
      title: json['title'],
      price: json['price'],
      selectedSize: json['selectedSize'],
      quantity: json['quantity'],
    );
  }
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  final ApiService _apiService = ApiService();

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  Future<void> fetchCartItems() async {
    try {
      var items = await _apiService.getCartItems();
      _items.clear();
      _items.addAll(items.map<CartItem>((item) => CartItem.fromJson(item)));
      notifyListeners();
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }
}
