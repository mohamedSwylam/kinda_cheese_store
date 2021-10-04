import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:backdrop/sub_header.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 11),
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
          backLayer: Center(
            child: Text("Back Layer"),
          ),
          frontLayer: Scaffold(
            backgroundColor: Colors.grey[300],
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
                        NetworkImage('https://s.france24.com/media/display/74b21b90-1d2c-11ec-bcd6-005056bf30b7/w:980/p:16x9/ecacab5c0e4dde620255e0a90f0472f8f20c545b.webp'),
                        NetworkImage('https://s.france24.com/media/display/74b21b90-1d2c-11ec-bcd6-005056bf30b7/w:980/p:16x9/ecacab5c0e4dde620255e0a90f0472f8f20c545b.webp'),
                        NetworkImage('https://s.france24.com/media/display/74b21b90-1d2c-11ec-bcd6-005056bf30b7/w:980/p:16x9/ecacab5c0e4dde620255e0a90f0472f8f20c545b.webp'),
                                ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                    child: Text(
                      'الاصناف',
                      style:Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 150,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildCategoriesItem(),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                    child: Text(
                      'اشهر المنتجات',
                      style:Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 370,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildProductItem(context),
                        separatorBuilder: (context, index) => SizedBox(),
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                        child: Text(
                          '...عرض المزيد',
                          style:TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                        child: Text(
                          'شوهد مؤخرا',
                          style:Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '50.99\$',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      'الحذاء الذهبي للناس الجامده جدا'
                                      , style: TextStyle(

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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '50.99\$',
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
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '50.99\$',
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
                                          onTap: () {},
                                        ),
                                        Container(
                                          height: 35,
                                          width: 40,
                                          child: Center(
                                              child: Text(
                                                '10',
                                                style: Theme.of(context).textTheme.bodyText1,
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
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
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
                              image: NetworkImage(
                                  'https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1200,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/TD1MTHU_SHOE_ANGLE_GLOBAL_MENS_TREE_DASHERS_THUNDER_b01b1013-cd8d-48e7-bed9-52db26515dc4.png?v=1601054861'),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Widget buildCategoriesItem() => Container(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.circular(20.0),
    boxShadow: [
      BoxShadow(
        color: Color(0xff37475A).withOpacity(0.2),
        blurRadius: 20.0,
        offset: const Offset(0, 10),
      )
    ],
  ),
  child:   Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('https://s.france24.com/media/display/74b21b90-1d2c-11ec-bcd6-005056bf30b7/w:980/p:16x9/ecacab5c0e4dde620255e0a90f0472f8f20c545b.webp'),
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
      Container(
        height: 30,
          width: 150,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            'موبيلات',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
          )),
    ],
  ),
);

Widget buildProductItem(context)=>Container(
  margin: EdgeInsets.all(15.0),
  width: 250,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
    color: Colors.grey[300],
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
      Image(
        image: NetworkImage('https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1200,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/TD1MTHU_SHOE_ANGLE_GLOBAL_MENS_TREE_DASHERS_THUNDER_b01b1013-cd8d-48e7-bed9-52db26515dc4.png?v=1601054861'),
        width: double.infinity,
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  '50.99\$',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Container(
                  width: 150,
                  child: Text(
                    'الحذاء الذهبي للناس الجامده جدا'
                    , style: TextStyle(

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(child: Icon(Icons.add_shopping_cart_outlined,size: 18,),onTap: (){},),
                Spacer(),
                Container(
                  width: 160,
                  child: Text(
                    'الحذاء الذهبي من اديدس الجامد جدا والروش جدا من اديداس الجمدوله جداد',
                    style: Theme.of(context).textTheme.caption,
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
);