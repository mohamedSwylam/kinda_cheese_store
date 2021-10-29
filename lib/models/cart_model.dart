import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CartModel with ChangeNotifier{
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;

  CartModel({this.id, this.title, this.price, this.imageUrl, this.quantity});
}
/*
class CartModel {
  String productId;
  String cartId;
  String userId;
  String title;
  double price;
  String imageUrl;
  int quantity;
  int cartQuantity=1;

  CartModel(
      {this.userId,
      this.cartId,
      this.title,
      this.price,
      this.imageUrl,
      this.quantity,
      this.cartQuantity,
      this.productId});

  CartModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    productId = json['productId'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    quantity = json['quantity'];
    cartId = json['cartId'];
    cartQuantity = json['cartQuantity'];
  }

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'title': title,
      'userId': userId,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'productId': productId,
      'cartQuantity': cartQuantity,
    };
  }
}
*/
