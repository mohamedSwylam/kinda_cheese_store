import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/modules/empty_cart.dart';
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
          double subTotal= price*quantity;
          return  InkWell(
            onTap: (){
              navigateTo(context, ProductDetailsScreen(productId: productId,));
            },
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${price}\$',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '  : السعر',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${subTotal.toStringAsFixed(2)}\$',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '  : السعر الكلي ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      height: 35,
                                      width: 35,
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
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                    ),
                                    onTap: () {
                                      StoreAppCubit.get(context).reduceItemByOne(productId, title, price, imageUrl);
                                    },
                                  ),
                                  Container(
                                    height: 35,
                                    width: 40,
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
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                  ),
                                  InkWell(
                                    child: Container(
                                      height: 35,
                                      width: 35,
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
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                    ),
                                    onTap: () {
                                      StoreAppCubit.get(context).addProductToCart(productId, title, price, imageUrl);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: (){
                                showDialogg(context, 'حذف المنتج من العربه', 'هل تريد حقل حذف المنتج من العربه', (){ StoreAppCubit.get(context).removeItem(productId);});
                              },
                              icon: Icon(
                                Feather.trash,
                              ),
                            ),
                          ],
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
              margin: const EdgeInsets.only(
                left: 20,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(16.0),
                  topLeft: const Radius.circular(16.0),
                ),
                color: Theme.of(context).backgroundColor,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
            ),
          );
        });
  }
}



