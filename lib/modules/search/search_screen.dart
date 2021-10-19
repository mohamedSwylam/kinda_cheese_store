import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/modules/search/search_by_header.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

import '../feeds_dialog.dart';
import '../product_details.dart';



class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SearchByHeader(
                  stackPaddingTop: 175,
                  titlePaddingTop: 80,
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "البحث",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsConsts.title,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  stackChild: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: searchController,
                      textAlign: TextAlign.end,
                      minLines: 1,
                      cursorColor: Colors.teal,
                      onChanged: (value){
                        searchController.text.toLowerCase();
                        StoreAppCubit.get(context).searchList=StoreAppCubit.get(context).searchQuery(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.teal,
                        ),
                        hintText: 'ابحث في المتجر',
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        prefixIcon: IconButton(
                          onPressed: searchController.text.isNotEmpty
                              ? null
                              : () {
                            searchController.clear();
                          },
                          icon: Icon(Feather.x,
                              color: searchController.text.isNotEmpty
                                  ? Colors.red
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: searchController.text.isNotEmpty && StoreAppCubit.get(context).searchList.isEmpty
                    ? Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Icon(
                      Feather.search,
                      size:60,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'لا توجد نتائج',
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ],
                )
                    : GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 240 / 420,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: List.generate(
                      searchController.text.isEmpty
                          ? StoreAppCubit.get(context).products.length
                          : StoreAppCubit.get(context).searchList.length, (index) {
                    return buildSearchItem(context,StoreAppCubit.get(context).products[index]);
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
Widget buildSearchItem(context,Product products)=>InkWell(
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
