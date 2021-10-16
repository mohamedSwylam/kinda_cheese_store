import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';
import 'package:store_app/styles/themes/themes.dart';

import 'empty_cart.dart';
import 'full_wishlist.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  const ProductDetailsScreen({this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var productAttr=StoreAppCubit.get(context).findById(productId);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                MaterialCommunityIcons.arrow_left,
                size: 25,
              ),
            ),
            backgroundColor: Colors.tealAccent,
            centerTitle: true,
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
            title: Text(
              'التفاصيل',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, EmptyCart());
                },
                icon: Icon(
                  MaterialCommunityIcons.cart,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(context, FullWishList());
                },
                icon: Icon(
                  MaterialCommunityIcons.heart,
                  size: 25,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(color: Colors.black12,),
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      '${productAttr.imageUrl}',),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 240.0,bottom: 20.0,),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                            },
                            icon: Icon(
                              MaterialCommunityIcons.content_save,
                              color: Colors.grey,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                            },
                            icon: Icon(
                              MaterialCommunityIcons.share_variant,
                              size: 25,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '${productAttr.title}',
                                style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 30),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                '${productAttr.price}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            myDivider(),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                '${productAttr.description}',
                                maxLines: 3,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            myDivider(),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${productAttr.productCategoryName}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width:40,),
                                  Text(
                                    'الصنف ',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${productAttr.brand}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width:40,),
                                  Text(
                                    'النوع ',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            myDivider(),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10,),
                                  Text(
                                    'بدون تقييم حتي الان',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    'كن اول من يقيم',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            myDivider(),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'المنتجات المقترحه',
                                style:Theme.of(context).textTheme.bodyText1,),
                            ),
                            Container(
                              height: 370,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildSuggestProduct(context),
                                separatorBuilder: (context, index) => SizedBox(),
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(side: BorderSide.none),
                          color: Colors.redAccent.shade400,
                          onPressed: StoreAppCubit.get(context).getCartItems.containsKey(productId)? (){}:() {
                            StoreAppCubit.get(context).addProductToCart(productId, productAttr.title, productAttr.price, productAttr.imageUrl);
                          },
                          child: Text(StoreAppCubit.get(context).getCartItems.containsKey(productId)? 'في العربه '.toUpperCase() :'اضف الي العربه'.toUpperCase(),
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(side: BorderSide.none),
                          color: Theme.of(context).backgroundColor,
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                'اشتري الان'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).textSelectionColor),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.payment,
                                color: Colors.green.shade700,
                                size: 19,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: StoreAppCubit.get(context).isDark
                            ? Theme.of(context).disabledColor
                            : ColorsConsts.subTitle,
                        height: 50,
                        child: InkWell(
                          splashColor: ColorsConsts.favColor,
                          onTap: () {},
                          child: Center(
                            child: Icon(
                              Ionicons.ios_heart_empty,
                              color: ColorsConsts.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])
              ),
            ],
          ),
        );
      },
    );
  }
}
Widget buildSuggestProduct(context)=>InkWell(
  onTap: (){
  },
  child:   Container(
    width: 150,
    margin: EdgeInsets.all(15.0),

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

                image: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t39.30808-6/244245333_3090825961197334_3277994336406470331_n.jpg?_nc_cat=100&_nc_rgb565=1&ccb=1-5&_nc_sid=b9115d&_nc_ohc=jpT1uVx5wWAAX_KuVQ0&_nc_ht=scontent.fcai20-3.fna&oh=9ff9aba19fe5e24a36e9275759a41b3f&oe=6162D5A2'),

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

                'كاجو وفسدق ولوز'

                , style: TextStyle(



                color: Colors.black,

                fontWeight: FontWeight.bold,

                fontSize: 15,

              ),

                textAlign: TextAlign.end,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

              ),

              Text(

                "*******",

                style: TextStyle(

                  color: Colors.orangeAccent,

                  fontSize: 20,

                ),

              ),

              Row(

                children: [

                  InkWell(child: Icon(Icons.more_horiz_rounded,size: 18,),onTap: (){},),

                  Spacer(),

                  Text(

                    '50.99\$',

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