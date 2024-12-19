// ignore_for_file: file_names, camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/user_model.dart';

// ignore: camel_case_types
//uurchlultuudiig hadgalah class - ChangeNotifier
class Global_provider extends ChangeNotifier {
  List<ProductModel> products = []; //product hadgalah list
  List<CartModel> cartItems = []; //cardItems hadgalah list
  List<ProductModel> favItems = [];
  late UserModel loggedUser;

  int currentIdx = 0; //ali huudsiig medeh index
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setProducts(List<ProductModel> data) {
    products = data;
    notifyListeners();
  }

  void setCartItems(List<CartModel> items) {
    if (items.isNotEmpty) {
      cartItems = items;
      notifyListeners();
    }
  }

  void addCartItem(ProductModel product) {
    CartModel data = ConversionHelper.productToCart(product);
    if (cartItems.any((e) => e.id == data.id)) {
      cartItems.removeWhere((e) => e.id == data.id);
    } else {
      cartItems.add(data);
    }
    notifyListeners();
  }

  void removeCartItem(CartModel data) {
    cartItems.removeWhere((e) => e.id == data.id);
    notifyListeners();
  }

  void addFavItem(ProductModel item) {
    bool itemExists = favItems.any((favItem) => favItem.id == item.id);
    if (!itemExists) {
      favItems.add(item);
      item.isFavorite = true;
      notifyListeners();
    }
  }

  void removeFavItem(ProductModel item) {
    bool itemExists = favItems.any((favItem) => favItem.id == item.id);
    if (itemExists) {
      item.isFavorite = false;
      favItems.remove(item);
      notifyListeners();
    }
  }

  void increaseQuantity(CartModel item) {
    if (cartItems.contains(item)) {
      int index = cartItems.indexWhere((element) => element == item);
      cartItems[index].count++;
    }
    notifyListeners();
  }

  void decreaseQuantity(CartModel item) {
    if (cartItems.contains(item)) {
      int index = cartItems.indexWhere((element) => element == item);
      if (cartItems[index].count > 1) {
        cartItems[index].count--;
      } else {
        cartItems[index].count = 0;
        cartItems.removeAt(index);
      }
    }
    notifyListeners();
  }

  void changeCurrentIdx(int idx) {
    currentIdx = idx;
    notifyListeners();
  }

  Future<void> login(UserModel user) async {
    if (user.id != -1) {
      _isLoggedIn = true;
      loggedUser = user;
      notifyListeners();
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  // Save token
  //flutter pub add flutter_secure_storage
  Future<void> saveToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
    notifyListeners();
  }

  // Retrieve token
  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }
}
