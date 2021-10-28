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
          return InkWell(
            onTap: () {
              navigateTo(
                  context,
                  ProductDetailsScreen(
                    productId: productId,
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
                          '${title}',
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
                                            '${price.toStringAsFixed(0)}',
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
                                            '${subTotal.toStringAsFixed(0)}',
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
                                            if (quantity > 0) {
                                              StoreAppCubit.get(context)
                                                  .reduceItemByOne(productId,
                                                      title, price, imageUrl);
                                            }
                                          },
                                        ),
                                        Container(
                                          height: 40,
                                          width: 65,
                                          child: Center(
                                              child: Text(
                                            '${quantity.toString()}',
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
                                            StoreAppCubit.get(context)
                                                .addProductToCart(productId,
                                                    title, price, imageUrl);
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
                                    '${imageUrl}',
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
                              navigateTo(
                                  context,
                                  OrderDetailsScreen(
                                    price: price,
                                    title: title,
                                    quantity: quantity,
                                    imageUrl: imageUrl,
                                    productId: productId,
                                    subTotal: subTotal,
                                    id: id,
                                  ));
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
                            StoreAppCubit.get(context).removeItem(productId);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
