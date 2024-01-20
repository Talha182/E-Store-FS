import 'package:flutter/material.dart';
import '../services/api_service.dart';

class WishlistItem {
  final String id;
  final String imageUrl;
  final String description;
  final String title;
  final String price;
  final String selectedSize;

  WishlistItem( {
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.title,
    required this.price,
    required this.selectedSize,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      price: json['price'],
      selectedSize: json['selectedSize'], description: json['description'],
    );
  }
}

class WishlistModel extends ChangeNotifier {
  final List<WishlistItem> _items = [];
  final ApiService _apiService = ApiService();

  List<WishlistItem> get items => _items;

  void addItem(WishlistItem item) {
    _items.add(item);
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    await _apiService.deleteWishlistItem(id);
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> fetchWishlistItems() async {
    try {
      var items = await _apiService.getWishlistItems();
      _items.clear();
      _items.addAll(items.map<WishlistItem>((item) => WishlistItem.fromJson(item)));
      notifyListeners();
    } catch (e) {
      print('Error fetching wishlist items: $e');
    }
  }
}
