import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/models/product_model.dart';
import '../widgets/fav_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
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
          List<ProductModel> favItems = provider.favItems;

          if (favItems.isEmpty) {
            return const Center(
              child: Text('Your favorites list is empty.'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favItems.length,
                    itemBuilder: (context, index) {
                      ProductModel item = favItems[index];
                      return ProductViewShop(item);
                    },
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

