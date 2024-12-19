import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/provider/globalProvider.dart';

class ProductViewShop extends StatelessWidget {
  final CartModel data;

  const ProductViewShop(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(
      builder: (context, provider, child) {
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image (Left Side)
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.image ?? 'https://img.freepik.com/premium-vector/white-texture-round-abstract-background-similar-fabric-texture_547648-1077.jpg?size=338&ext=jpg&ga=GA1.1.2082370165.1715644800&semt=sph'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Text(
                      data.title ?? 'Cart is empty',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Product Price
                    Text(
                      '\$${((data.price ?? 0) * data.count).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Quantity Buttons
                    Row(
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              provider.decreaseQuantity(data);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white70,
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          data.count.toString(),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(width: 8.0),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              provider.increaseQuantity(data);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white70,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
