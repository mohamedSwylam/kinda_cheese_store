import 'package:flutter/material.dart';

class CartModel with ChangeNotifier{
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;

  CartModel({this.id, this.title, this.price, this.imageUrl, this.quantity});
}