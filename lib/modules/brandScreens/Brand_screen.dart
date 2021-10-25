import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/shared/components/components.dart';

import '../product_details.dart';

class BrandScreen extends StatefulWidget {
  final String brandName;

  const BrandScreen({this.brandName});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Row(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: NavigationRail(
                            minWidth: 56.0,
                            groupAlignment: 1.0,
                            selectedIndex:
                                StoreAppCubit.get(context).selectedBrandIndex,
                            onDestinationSelected:
                                StoreAppCubit.get(context).changeIndex,
                            labelType: NavigationRailLabelType.all,
                            leading: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: NetworkImage(
                                        "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                            selectedLabelTextStyle: TextStyle(
                              color: Color(0xffffe6bc97),
                              fontSize: 20,
                              letterSpacing: 1,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.5,
                            ),
                            unselectedLabelTextStyle: TextStyle(
                              fontSize: 15,
                              letterSpacing: 0.8,
                            ),
                            destinations: [
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination('redmi',
                                      StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("Apple",
                                      StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("lenovo",
                                      StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("oppo",
                                      StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("realme",
                                      StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("Samsung",
                                      StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("Huawei",
                                      StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("nokia",
                                  StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("sony",
                                  StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("vivo",
                                  StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("tecno",
                                  StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("infnix",
                                  StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("itel",
                                  StoreAppCubit.get(context).padding),
                              StoreAppCubit.get(context)
                                  .buildRotatedTextRailDestination("All",
                                      StoreAppCubit.get(context).padding),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // This is the main content.
                ConditionalBuilder(
                  condition: true,
                  builder: (context) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder:  (context, index)  {
                            var list = StoreAppCubit.get(context).brandList;
                            return  buildBrandItem(context, list[index]);
                          },
                          separatorBuilder: (context, index) => Container(
                            height: 8,
                          ),
                          itemCount:
                              StoreAppCubit.get(context).brandList.length,
                        ),
                      ),
                    ),
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        });
  }
}

Widget buildBrandItem(context, Product products) => InkWell(
      onTap: () {
        navigateTo(
            context,
            ProductDetailsScreen(
              productId: products.id,
            ));
      },
      child: Container(
        //  color: Colors.red,
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        margin: EdgeInsets.only(right: 20.0, bottom: 5, top: 18),
        constraints: BoxConstraints(
            minHeight: 150, minWidth: double.infinity, maxHeight: 180),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  image: DecorationImage(
                    image: NetworkImage(products.imageUrl),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2.0)
                  ],
                ),
              ),
            ),
            FittedBox(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10.0)
                    ]),
                width: 160,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${products.title}',
                      maxLines: 4,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textSelectionColor),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FittedBox(
                      child: Text('US ${products.price} \$',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30.0,
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('${products.brand}',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
