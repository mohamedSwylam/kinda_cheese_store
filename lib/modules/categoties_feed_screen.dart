import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/modules/product_details.dart';
import 'package:store_app/shared/components/components.dart';
import 'feeds_dialog.dart';

class CategoriesFeedScreen extends StatelessWidget {
  final String categoryName;
  const CategoriesFeedScreen({this.categoryName});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var productAttr=StoreAppCubit.get(context).findByCategory(categoryName);
        return Scaffold(
          body: GridView.builder(
            shrinkWrap: true,
            itemCount: StoreAppCubit.get(context).findByCategory(categoryName).length,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              var list=StoreAppCubit.get(context).findByCategory(categoryName);
              return buildGridView(context,list[index]);
            },
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

              Text(

                "*******",

                style: TextStyle(

                  color: Colors.orangeAccent,

                  fontSize: 20,

                ),

              ),

              Row(

                children: [

                  InkWell(child: Icon(Icons.more_horiz_rounded,size: 18,),onTap: () async {
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