import 'package:json_annotation/json_annotation.dart';
import 'package:shop_app/models/product_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;
  int count;

  CartModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.count = 1,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  static List<CartModel> fromList(List<dynamic> jsonList) =>
      jsonList.map((item) => CartModel.fromJson(item)).toList();

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}



class ConversionHelper {
  static CartModel productToCart(ProductModel product) {
    return CartModel(
    id: product.id,
    title: product.title,
    price: product.price,
    description: product.description,
    category: product.category,
    image:product.image,
    count : product.count,
    );
  }
}