// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail.dart';
import '../models/product_model.dart';
import '../provider/globalProvider.dart';
import 'package:shop_app/screens/login_page.dart';

class ProductViewShop extends StatelessWidget {
  final ProductModel data;

  const ProductViewShop(this.data, {super.key});
  //darah uyd uur huudasruu usreh
  _onTap(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => Product_detail(data)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data.image!),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                // Product details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '\$${data.price!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8.0,
              right: 4.0,
              child: Consumer<Global_provider>(
                builder: (context, provider, child) {
                  bool isFavorite = provider.favItems.contains(data);
                  return ElevatedButton(
                    onPressed: () {
                      if(!provider.isLoggedIn){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage()
                              ),
                            );
                      }
                        if (!isFavorite) {
                          provider.addFavItem(data);
                        } else {
                          provider.removeFavItem(data);
                        }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white70,
                    ),
                    child: Icon(
                      data.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
