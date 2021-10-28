import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/full_cart.dart';
import 'package:store_app/modules/order_details_screen.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return StoreAppCubit.get(context).getCartItems.isEmpty
              ? Scaffold(
                  body: EmptyCart(),
                )
              : Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        showDialogg(context, 'تنظيف العربه',
                            'هل تريد حقل حذف جميع المنتجات من العربه', () {
                          StoreAppCubit.get(context).clearCart();
                        });
                      },
                      icon: Icon(
                        Feather.trash,
                      ),
                    ),
                    backgroundColor: Colors.tealAccent,
                    elevation: 0,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.tealAccent,
                            Colors.green[100],
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 11),
                        child: Text(
                          'العربه (${StoreAppCubit.get(context).getCartItems.length})',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FullCart(
                          id: StoreAppCubit.get(context)
                              .getCartItems
                              .values
                              .toList()[index]
                              .id,
                          productId: StoreAppCubit.get(context)
                              .getCartItems
                              .keys
                              .toList()[index],
                          price: StoreAppCubit.get(context)
                              .getCartItems
                              .values
                              .toList()[index]
                              .price,
                          title: StoreAppCubit.get(context)
                              .getCartItems
                              .values
                              .toList()[index]
                              .title,
                          imageUrl: StoreAppCubit.get(context)
                              .getCartItems
                              .values
                              .toList()[index]
                              .imageUrl,
                          quantity: StoreAppCubit.get(context)
                              .getCartItems
                              .values
                              .toList()[index]
                              .quantity,
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                        height: 8,
                      ),
                      itemCount: StoreAppCubit.get(context).getCartItems.length,
                    ),
                  ),
                 // bottomSheet: bottomSheet(context),
                );
        });
  }
}

/*
Widget bottomSheet(context) => Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 05.0, left: 25, top: 10),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${StoreAppCubit.get(context).totalAmount.toStringAsFixed(0)}ج.م',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '  : المجموع',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: RaisedButton(
                    onPressed: ()  {
                      navigateTo(context, OrderDetailsScreen());
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.redAccent),
                    ),
                    color: Colors.redAccent,
                    child: Text(
                      'اتمام الطلب',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
*/
