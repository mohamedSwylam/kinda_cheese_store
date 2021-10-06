import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:backdrop/sub_header.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/modules/backlayer.dart';
import 'package:store_app/modules/category.dart';

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
                        AssetImage('assets/images/cover.jpg'),
                        AssetImage('assets/images/cover.jpg'),
                        AssetImage('assets/images/cover.jpg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                    child: Text(
                      'الاصناف',
                      style:Theme.of(context).textTheme.bodyText1,),),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 150,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            CategoryWidget(index: index,),
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
                       style:Theme.of(context).textTheme.bodyText1,),),
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
                          style:Theme.of(context).textTheme.bodyText1,),),
                    ],
                  ),
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
  }
}
Widget buildCategoriesItem(List categories) => Container(
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
        image: AssetImage('{categories}'),
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

Widget buildProductItem(context)=>Container
  (
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
        child: Image(
          image: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t39.30808-6/243381478_3088274774785786_7059132073990594328_n.jpg?_nc_cat=103&_nc_rgb565=1&ccb=1-5&_nc_sid=825194&_nc_ohc=AXQ8lp-GK1UAX8g_ZlK&tn=0CxaeDgygeK3Ichd&_nc_ht=scontent.fcai20-3.fna&oh=2f0c1d1af5d49478bec1dfb85328d092&oe=6162705B'),
          width: double.infinity,
        ),
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
                    'صوابع موتزريلا متبله'
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
                InkWell(child: Icon(Icons.add_shopping_cart_outlined,size: 18,color: Colors.teal,),onTap: (){},),
                Spacer(),
                Container(
                  width: 160,
                  child: Text(
                    'صوابع مودزريلا متبله مش اي صوابع جبنه يتقال عليها صوابع جبنه مودزريلا دي زي المطاعم بالظبط الصوابع مش احب الجبن علي قلوبنا',
                    style: TextStyle(color: Colors.black,fontSize:11),
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
Widget buildWatchedRecentlyItem(context)=>Stack(
  children: [
    Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.end,
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
                    maxLines:2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('اضف الي العربه',style: TextStyle(fontSize: 18,color: Colors.redAccent,fontWeight: FontWeight.w900),),
                      SizedBox(width: 5,),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
          onPressed: (){},
        ),
      ),
    ),
  ],
);