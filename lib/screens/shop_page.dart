import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/repository/repository.dart';
import '../widgets/ProductView.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  Future<void> setProducts(context) async {
      MyRepository repository = MyRepository();
      List<ProductModel> products = await repository.fetchProductData();
      Provider.of<Global_provider>(context, listen: false).setProducts(products);
  }
  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<Global_provider>(context, listen: false);
    if (globalProvider.products.isEmpty) {
      setProducts(context);
    }
    return Consumer<Global_provider>(
      builder: (context, provider, _) {
        if (provider.products.isEmpty) {
          // Show loading indicator if products list is still empty
          return const Center(child: CircularProgressIndicator());
        } else {
          // Show products
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Products",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: List.generate(
                      provider.products.length,
                      (index) => ProductViewShop(provider.products[index]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      },
    );
  }
}
