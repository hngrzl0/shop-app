import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/repository/repository.dart';

class ProductViewShop extends StatelessWidget {
  final ProductModel data;

  const ProductViewShop(this.data, {super.key});
  Future<void> addToCart(userId, product, context) async {
    MyRepository repository = MyRepository();
    await repository.addCartItem(userId, ConversionHelper.productToCart(product));
    Provider.of<Global_provider>(context, listen: false)
        .addCartItem(product);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(
      builder: (context, provider, child) {
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image (Left Side)
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data.image!),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  // Product Information and Buttons (Right Side)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Title with Padding
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: Text(
                            data.title!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        // Product Price
                        Text(
                          '\$${(data.price! * data.count).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    //
                    provider.removeFavItem(data);
                  },
                ),
              ),
              Positioned(
                  top: 70,
                  right: 0,
                  child: ElevatedButton(
                      onPressed: () {
                        addToCart(provider.loggedUser.id, data, context);
                        //provider.addCartItem(ConversionHelper.productToCart(data));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.red,
                      ),
                      child: const Icon(Icons.shopping_cart))),
            ],
          ),
        );
      },
    );
  }
}
