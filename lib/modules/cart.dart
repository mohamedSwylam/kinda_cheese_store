import 'package:flutter/material.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/full_cart.dart';

import 'empty_wishlist.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullCart(),
    );
  }
}
