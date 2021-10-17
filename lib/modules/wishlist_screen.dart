import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/empty_wishlist.dart';
import 'package:store_app/modules/full_cart.dart';
import 'package:store_app/modules/full_wishlist.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

class WishListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return StoreAppCubit.get(context).getWishListItem.isEmpty
              ? Scaffold(
            body: EmptyWishList(),
          )
              : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  showDialogg(context, 'تنظيف المفضله', 'هل تريد حقل حذف جميع المنتجات من تفضيلاتك', (){ StoreAppCubit.get(context).clearWishList();});
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
                    'المفضله (${StoreAppCubit.get(context).getWishListItem.length})',
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
                  return FullWishList(
                    id:  StoreAppCubit.get(context).getWishListItem.values.toList()[index].id,
                    productId: StoreAppCubit.get(context).getWishListItem.keys.toList()[index],
                    price: StoreAppCubit.get(context).getWishListItem.values.toList()[index].price,
                    title: StoreAppCubit.get(context).getWishListItem.values.toList()[index].title,
                    imageUrl: StoreAppCubit.get(context).getWishListItem.values.toList()[index].imageUrl,
                  );
                },
                separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
                itemCount: StoreAppCubit.get(context).getWishListItem.length,
              ),
            ),
          );
        });
  }
}

