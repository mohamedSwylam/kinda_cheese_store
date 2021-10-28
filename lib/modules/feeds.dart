import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/empty_wishlist.dart';
import 'package:store_app/modules/full_wishlist.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/modules/wishlist_screen.dart';
import 'package:store_app/shared/components/components.dart';

import 'cart_screen.dart';
import 'feeds_dialog.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Badge(
                  badgeColor: Colors.teal,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  position: BadgePosition.topEnd(top: 0,end: 0),
                  badgeContent: Text(StoreAppCubit.get(context).getCartItems.length.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                  child: IconButton(
                    onPressed: () {
                      navigateTo(context, CartScreen());
                    },
                    icon: Icon(
                      MaterialCommunityIcons.cart,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding (
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Badge(
                    badgeColor: Colors.teal,
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 0,end: 0),
                    badgeContent: Text(StoreAppCubit.get(context).getWishListItem.length.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context, WishListScreen());
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        size: 25,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
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
                    horizontal: 20.0, vertical: 11),
                child: Text(
                  'المنتجات',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: Container(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: StoreAppCubit.get(context).products.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                var list=StoreAppCubit.get(context).products;
                return buildGridView(context,list[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
Widget buildGridView(context,Product products)=>InkWell(
  onTap: (){
    navigateTo(context, ProductDetailsScreen(productId: products.id,));
  },
  child:   Container(

    margin: EdgeInsets.all(12.0),

    clipBehavior: Clip.antiAliasWithSaveLayer,

    decoration: BoxDecoration(

      color: Theme.of(context).backgroundColor,

      borderRadius: BorderRadius.circular(20.0),

      boxShadow: [

        BoxShadow(

          color: Color(0xff37475A).withOpacity(0.2),

          blurRadius: 20.0,

          offset: const Offset(0, 10),

        )

      ],

    ),

    child: Column(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [

        Stack(

          alignment: AlignmentDirectional.bottomStart,

          children: [

            Expanded(

              child: Image(

                fit: BoxFit.fill,

                height: 180,

                image: NetworkImage(products.imageUrl),

                width: double.infinity,

              ),

            ),

            Container(

              color: Colors.red,

              padding: EdgeInsets.symmetric(horizontal: 5.0),

              child: Text(

                'جديد',

                style: TextStyle(

                  fontSize: 8.0,

                  color: Colors.white,

                ),

              ),

            ),

          ],

        ),

        Padding(

          padding: const EdgeInsets.all(10.0),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.end,

            children: [

              Text(
                products.title
                , style: TextStyle(



                color: Colors.black,

                fontWeight: FontWeight.bold,

                fontSize: 15,

              ),

                textAlign: TextAlign.end,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

              ),
SizedBox(height: 10,),
              Text(

                "*******",

                style: TextStyle(

                  color: Colors.orangeAccent,

                  fontSize: 20,

                ),

              ),

              Row(

                children: [

                  InkWell(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.more_horiz_rounded,size: 22,),
                  ),onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => FeedsDialog(
                        productId: products.id,
                      ),
                    );
                  },),

                  Spacer(),

                  Text(

                   '${products.price}',

                    style: TextStyle(

                      fontSize: 15.0,

                      color: Colors.grey,

                    ),

                  ),

                ],

              )

            ],

          ),

        )

      ],

    ),

  ),
);