import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/empty_wishlist.dart';
import 'package:store_app/modules/full_wishlist.dart';
import 'package:store_app/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: (){
                navigateTo(context, EmptyCart());
              },
              icon: Icon(
                MaterialCommunityIcons.cart,
                color: Colors.black,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: (){
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
          itemCount: 20,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            return buildGridView(context);
          },
        ),
      ),
    );
  }
}
Widget buildGridView(context)=>Container(
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
);