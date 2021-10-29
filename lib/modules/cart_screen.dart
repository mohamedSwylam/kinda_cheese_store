
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
          return StoreAppCubit.get(context).carts.isEmpty
              ? Scaffold(
            body: EmptyCart(),
          )
              : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  /*showDialogg(context, 'تنظيف العربه',
                      'هل تريد حقل حذف جميع المنتجات من العربه', () {
                        StoreAppCubit.get(context).clearCart();
                      });*/
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
                    'العربه (${StoreAppCubit.get(context).carts.length})',
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
                  var list=StoreAppCubit.get(context).carts;
                  return buildCartItem(list[index],context);
                },
                separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
                itemCount: StoreAppCubit.get(context).carts.length,
              ),
            ),
            // bottomSheet: bottomSheet(context),
          );
        });
  }
}
Widget buildCartItem(CartModel model,context) => InkWell(
  onTap: () {
    navigateTo(
        context,
        ProductDetailsScreen(
          productId: model.productId,
        ));
  },
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Stack(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                '${model.title}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ج.م',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${model.price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '  : السعر',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ج.م',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${(model.price*model.quantity).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '  : السعر الكلي ',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  height: 40,
                                  width: 45,
                                  child: Icon(
                                    Entypo.minus,
                                    color: Colors.teal,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    border: Border.all(
                                      color: Colors.grey[300],
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft:
                                        Radius.circular(10)),
                                  ),
                                  clipBehavior:
                                  Clip.antiAliasWithSaveLayer,
                                ),
                                onTap: () {
                                  /*   if (quantity > 0) {
                                    StoreAppCubit.get(context)
                                        .reduceItemByOne(productId,
                                        title, price, imageUrl);
                                  }
                                },*/
                                },
                              ),
                              Container(
                                height: 40,
                                width: 65,
                                child: Center(
                                    child: Text(
                                      '${model.quantity.toString()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.black),
                                    )),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey[300],
                                    width: 1.0,
                                  ),
                                ),
                                clipBehavior:
                                Clip.antiAliasWithSaveLayer,
                              ),
                              InkWell(
                                child: Container(
                                  height: 40,
                                  width: 45,
                                  child: Icon(
                                    Entypo.plus,
                                    color: Colors.teal,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    border: Border.all(
                                      color: Colors.grey[300],
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight:
                                        Radius.circular(10)),
                                  ),
                                  clipBehavior:
                                  Clip.antiAliasWithSaveLayer,
                                ),
                                onTap: () {
                                /*  StoreAppCubit.get(context)
                                      .addProductToCart(productId,
                                      title, price, imageUrl);*/
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Container(
                    width: 120,
                    height: 165,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          '${model.imageUrl}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.06,
                child: RaisedButton(
                  onPressed: () {
                    /*navigateTo(
                        context,
                        OrderDetailsScreen(
                          price: price,
                          title: title,
                          quantity: quantity,
                          imageUrl: imageUrl,
                          productId: productId,
                          subTotal: subTotal,
                          id: id,
                        ));*/
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
          margin: const EdgeInsets.only(
              left: 10, bottom: 10, right: 10, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).backgroundColor,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
        Positioned(
          child: Container(
            height: 30,
            width: 30,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              color: Colors.redAccent,
              child: CircleAvatar(
                radius: 18.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.close,
                  size: 20.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                showDialogg(context, 'حذف المنتج من العربه',
                    'هل تريد حقل حذف المنتج من العربه', () {
                      StoreAppCubit.get(context).removeFromCart(model.cartId);
                    });
              },
            ),
          ),
        ),
      ],
    ),
  ),
);
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
