import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String productCategoryName;
  final String brand;
  final bool isFavorite;
  final bool isPopular;
  final int quantity;

  Product({this.id, this.title, this.description, this.price, this.imageUrl, this.productCategoryName, this.brand, this.isFavorite, this.isPopular, this.quantity});
}