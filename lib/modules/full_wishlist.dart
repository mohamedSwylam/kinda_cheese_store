import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

class FullWishList extends StatelessWidget {
  final String productId;
  final String id;
  final double price;
  final String title;
  final String imageUrl;
  const FullWishList(
      {@required this.id,
        @required this.productId,
        @required this.price,
        @required this.title,
        @required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            onTap: (){
              navigateTo(context, ProductDetailsScreen(productId: productId,));
            },
            child: Stack(
              children: [
                Container(
                  height: 130,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${title}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${price}',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
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
                      ),],
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
                Positioned(
                  top: 20,
                  left: 10,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      color: Colors.redAccent,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed:(){
                        showDialogg(context, 'حذف المنتج من المفضله', 'هل تريد حقا حذف المنتج من التفضيلات', (){ StoreAppCubit.get(context).removeItemFromWishList(productId);});
                      }
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}



