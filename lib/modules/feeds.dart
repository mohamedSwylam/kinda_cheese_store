import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              MaterialCommunityIcons.cart,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Icon(
              Feather.heart,
              size: 22,
              color: Colors.red,
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
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage('https://cdn.allbirds.com/image/fetch/q_auto,f_auto/w_1200,f_auto,q_auto,b_rgb:f5f5f5/https://cdn.shopify.com/s/files/1/0074/1307/1990/products/TD1MTHU_SHOE_ANGLE_GLOBAL_MENS_TREE_DASHERS_THUNDER_b01b1013-cd8d-48e7-bed9-52db26515dc4.png?v=1601054861'),
            width: double.infinity,
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