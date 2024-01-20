import 'dart:convert';
import 'package:e_commerce/Custom_Widgets/Navbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000"; // For Android emulator
  Future<List<dynamic>> getDresses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/dresses'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load dresses');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<dynamic>> getJackets() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/jackets'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load jackets');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<dynamic>> getJeans() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/jeans'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load jeans');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<dynamic>> getShoes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/shoes'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load shoes');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }

  Future<void> addCartItem(Map<String, dynamic> cartItem) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cartItem),
      );
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 201) {
        print('Item added to cart successfully');
      } else {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error adding item to cart: $e');
    }
  }

  Future<List<dynamic>> getCartItems() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cart'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      throw Exception('Error loading cart items: $e');
    }
  }

  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );
      if (response.statusCode == 201) {
        print('User registered successfully');
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error registering user: $e');
      throw Exception('Error registering user: $e');
    }
  }
  Future<void> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        print('Login successful');
        // You can also handle navigation or state management here if needed
      } else {
        print('Failed to login');
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error logging in: $e');
      throw Exception('Error logging in: $e');
    }
  }

}
