import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/order_details_screen.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

class FullOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'mezzzzzo',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontSize: 20),
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
                                          '20',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '  : الاجمالي ',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '.....قيد التفعيل',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
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
                        height: 145,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/c/c1/Lionel_Messi_20180626.jpg',
                            ),
                          ),
                        ),
                      ),
                    ],
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
          );
        });
  }
}
