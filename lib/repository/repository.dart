// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/services/httpService.dart';

class MyRepository {
  final HttpService httpService = HttpService();

  MyRepository();
  Future<List<ProductModel>> fetchProductData() async {
    try {
      var jsonData = await httpService.getData('products', null);
      List<ProductModel> data = ProductModel.fromList(jsonData);
      return data;
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

  Future<List<UserModel>> fetchUserData() async {
    try {
      var jsonData = await httpService.getData('users', null);
      List<UserModel> users = UserModel.fromList(jsonData);
      return users;
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

    Future<Map<String, dynamic>>login(String username, String password) async {
    try {
      dynamic data = {"username": username, "password": password};
      var jsonData = await httpService.postData('auth/login', null, data);
      String token = jsonData["token"];
      //fetch users
      List<UserModel> users = await fetchUserData();
      UserModel? user = users.firstWhere(
          (u) => u.username == username && u.password == password,
          orElse: () => UserModel(id: -1));

      if (user.id != -1) {
        return {"token": token, "user": user};
      }else{
        throw Exception('User not found');
      }
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

  Future<List<CartModel>> fetchUserCart(int userId) async {
    try {
      var jsonData = await httpService.getData('carts/user/$userId', null);
      List<CartModel> cartItems = CartModel.fromList(jsonData);
      return cartItems;
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }

  Future<void> addCartItem(int userId, CartModel item) async {
    try {
      await httpService.postData(
        'carts',
        null,
        {
          "userId": userId,
          "date": DateTime.now().toString(),
          "products": [{"productId": item.id, "quantity": item.count}],
        },
      );
      print('Item added to server cart successfully');
    } catch (e) {
      print('Failed to add item to server cart: $e');
      throw e;
    }
  }

  Future<void> removeCartItem(int cartItemId) async {
    try {
      await httpService.deleteData('carts/$cartItemId', null, null);
      print('Item removed from server cart successfully');
    } catch (e) {
      print('Failed to remove item from server cart: $e');
      throw e;
    }
  }
}
