/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/order_details_screen.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

class FullCart extends StatelessWidget {
  final String productId;
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  const FullCart(
      {@required this.id,
        @required this.productId,
        @required this.price,
        @required this.quantity,
        @required this.title,
        @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          double subTotal = price * quantity;
          return
        });
  }
}*/
