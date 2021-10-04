import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

class FullCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Icon(
                  Feather.trash,
                  color: Colors.black,
                ),
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
                      horizontal: 10.0, vertical: 11),
                  child: Text(
                    'العربه',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildCartItem(context);
                },
                separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
                itemCount: 10,
              ),
            ),
            bottomSheet: bottomSheet(context),
          );
        });
  }
}

Widget buildCartItem(
  context,
) =>
    Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'سامسونج جلاكسي مساحه كبيره جدا جداجدا مساحه كبير',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline6,
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
        bottom: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(16.0),
          topLeft: const Radius.circular(16.0),
        ),
        color: Theme.of(context).backgroundColor,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );

Widget bottomSheet(context) => Container(
      height: 125,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0,left: 25,top: 10),
            child: Row(
              children: [
                Text(
                  '50.99\$',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Text(
                  'السعر الكلي ',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.teal),
              ),
              color: Colors.teal,
              child: Text(
                'اتمام الطلب',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
