import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/screens/login_page.dart';
import '../widgets/cart_item.dart';

class BagsPage extends StatelessWidget {
  const BagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Bag',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.white70,
        centerTitle: true,
      ),
      body: Consumer<Global_provider>(
        builder: (context, provider, child) {
          if (!provider.isLoggedIn) {
            return const Center(
              child: Text('Please log in to see your cart items.'),
            );
          }

          List<CartModel> cartItems = provider.cartItems;
          double totalPrice = 0.0;

          if (cartItems.isNotEmpty) {
            totalPrice = cartItems
                .map((item) => (item.price ?? 0.0) * item.count)
                .reduce((value, element) => value + element);
          }

          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your bag is empty.'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      CartModel item = cartItems[index];
                      return ProductViewShop(item);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!provider.isLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          // Proceed with checkout logic
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(50), // Rounded edges
                        ),
                      ),
                      child: const Text(
                        'Check Out',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
