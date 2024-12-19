import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/provider/globalProvider.dart';
import 'package:shop_app/repository/repository.dart';

// ignore: camel_case_types
class Product_detail extends StatelessWidget {
  final ProductModel product;
  //baiguulagchaar damjij medeelel orj irne
  const Product_detail(this.product, {super.key});
  Future<void> addToCart(Global_provider provider,userId, product, context) async {
    MyRepository repository = MyRepository();
    await repository.addCartItem(userId, ConversionHelper.productToCart(product));
    
    provider.addCartItem(product);
  }

  @override
  Widget build(BuildContext context) {
    //consumer- uurchlultiig sonsoh heseg
    return Consumer<Global_provider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product Detail',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          backgroundColor: Colors.white70,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.red),
        ),
        body: Column(
          children: [
            Image.network(
              product.image!,
              height: 200,
            ),
            Text(
              product.title!,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              product.description!,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'PRICE: \$${product.price}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addToCart(provider, provider.loggedUser.id, product, context);
            //provider.addCartItem(ConversionHelper.productToCart(product));
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.shopping_cart),
        ),
      );
    });
  }
}
