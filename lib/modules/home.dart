import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:backdrop/sub_header.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/brand_model.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/modules/backlayer.dart';
import 'package:store_app/modules/brandScreens/Brand_screen.dart';
import 'package:store_app/modules/category.dart';
import 'package:store_app/modules/categoties_feed_screen.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: BackdropScaffold(
              headerHeight: MediaQuery.of(context).size.height * .25,
              appBar: BackdropAppBar(
                leading: BackdropToggleButton(
                  icon: AnimatedIcons.home_menu,
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 11),
                        child: Text(
                          "الرئيسية",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        onPressed: () {},
                        iconSize: 15,
                        icon: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                          backgroundColor: Colors.grey[300],
                          radius: 13,
                        ),
                      ),
                    ],
                  ),
                ],
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
              ),
              backLayer: BackLayer(),
              frontLayer: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 160.0,
                        width: double.infinity,
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          autoplay: true,
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotSize: 5.0,
                          dotIncreasedColor: Colors.teal,
                          dotBgColor: Colors.black.withOpacity(.2),
                          dotPosition: DotPosition.bottomCenter,
                          dotVerticalPadding: 0.0,
                          showIndicator: true,
                          indicatorBgPadding: 7.0,
                          images: [
                            AssetImage('assets/images/banner1.jpg'),
                            AssetImage('assets/images/banner2.jpg'),
                            AssetImage('assets/images/banner3.jpg'),
                            AssetImage('assets/images/banner4.jpg'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Text(
                          'الاصناف',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          height: 150,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index){
                              var list = StoreAppCubit.get(context).categories;
                             return StoreAppCubit.get(context).buildCategoryItem(context, list[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            itemCount: 7,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            FlatButton(
                              onPressed: () {
                              },
                              child: Text(
                                '...عرض المزيد',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: Colors.red),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'اشهر الماركات',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 210,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Swiper(
                          itemCount: 7,
                          autoplay: true,
                          viewportFraction: 0.8,
                          scale: 0.9,
                          itemBuilder: (BuildContext ctx, int index) {
                            var list = StoreAppCubit.get(context).brands;
                            return StoreAppCubit.get(context).buildPopularBrandsItem(list[index],context,);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          children: [
                            FlatButton(
                              onPressed: () {
                              },
                              child: Text(
                                '...عرض المزيد',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: Colors.red),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'اشهر المنتجات',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          height: 370,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var list = StoreAppCubit.get(context).products
                                  .where((element) => element.isPopular == true)
                                  .toList();
                              return buildPopularProductItem(
                                  context, list[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(),
                            itemCount: StoreAppCubit.get(context)
                                .products
                                .where((element) => element.isPopular == true)
                                .length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          children: [
                            FlatButton(
                              onPressed: () {
                              },
                              child: Text(
                                '...عرض المزيد',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: Colors.red),
                              ),
                            ),
                            Spacer(),
                            Text(
                              'شوهد مؤخرا',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildWatchedRecentlyItem(context);
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 8,
                        ),
                        itemCount: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildPopularProductItem(context, Product products) => InkWell(
      onTap: () {
        navigateTo(
            context,
            ProductDetailsScreen(
              productId: products.id,
            ));
      },
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: 250,
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
            Expanded(
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(products.imageUrl),
                    width: double.infinity,
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: Icon(
                      Entypo.star,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: Icon(
                      Entypo.star_outlined,
                      color:  StoreAppCubit.get(context).getWishListItem.containsKey(products.id)? Colors.redAccent:Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 32.0,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Theme.of(context).backgroundColor,
                      child: Text(
                        '\$ ${products.price}',
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        width: 150,
                        child: Text(
                          products.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Icon(
                          StoreAppCubit.get(context).getCartItems.containsKey(products.id)? MaterialCommunityIcons.check_all : MaterialCommunityIcons.cart_plus,
                          size: 18,
                          color: Colors.teal,
                        ),
                        onTap: () {
                          StoreAppCubit.get(context).addProductToCart(
                              products.id,
                              StoreAppCubit.get(context).findById(products.id).title,
                              StoreAppCubit.get(context).findById(products.id).price,
                              StoreAppCubit.get(context).findById(products.id).imageUrl);
                        },
                      ),
                      Spacer(),
                      Container(
                        width: 160,
                        child: Text(
                          products.description,
                          style: TextStyle(color: Colors.black, fontSize: 11),
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
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


Widget buildWatchedRecentlyItem(context) => Stack(
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الجمبرى الكرسبى',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '50.99\$',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'جامبو يعني قرمشه وحركات جاهز علي القلي علطول متوفر في المحل فوري ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اضف الي العربه',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Entypo.plus,
                            size: 25,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
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
                        'https://scontent.fcai20-3.fna.fbcdn.net/v/t39.30808-6/244225167_3089622827984314_8334024115995724435_n.jpg?_nc_cat=110&_nc_rgb565=1&ccb=1-5&_nc_sid=b9115d&_nc_ohc=S7gN1p8M9kQAX80nkNu&_nc_oc=AQn-L9T5BxqLyg1ja2uqgnY8OI5M6I_pzeuizjG8NzGlgZZGac11KgCRiCNETXS-VnQ&_nc_ht=scontent.fcai20-3.fna&oh=2787a0ae21acf40ea816decb35044909&oe=61624898'),
                  ),
                ),
              ),
            ],
          ),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 15,
            top: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(16.0),
              topLeft: const Radius.circular(16.0),
              bottomRight: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0),
            ),
            color: Theme.of(context).backgroundColor,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
        Positioned(
          top: 155,
          left: 7,
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
                  Icons.favorite_border,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );



