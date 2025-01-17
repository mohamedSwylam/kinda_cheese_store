import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/modules/Login_screen/cubit/cubit.dart';
import 'package:store_app/modules/empty_cart.dart';
import 'package:store_app/modules/feeds.dart';
import 'package:store_app/modules/wishlist_screen.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

import 'cart_screen.dart';

class BackLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return BlocConsumer<StoreAppCubit,StoreAppStates> (
      listener: (context,state){},
      builder: (context,state){
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.tealAccent,
                      Colors.green[100],
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            Positioned(
              top: -100.0,
              left: 140.0,
              child: Transform.rotate(
                angle: -0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  width: 150,
                  height: 250,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 100.0,
              child: Transform.rotate(
                angle: -0.8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  width: 150,
                  height: 300,
                ),
              ),
            ),
            Positioned(
              top: -50.0,
              left: 60.0,
              child: Transform.rotate(
                angle: -0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  width: 150,
                  height: 200,
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 0.0,
              child: Transform.rotate(
                angle: -0.8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  width: 150,
                  height: 200,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child : InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${StoreAppCubit.get(context).profileImage}'),
                            radius: 45,
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            navigateTo(context, WishListScreen());
                          },
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateTo(context, WishListScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                          image:   AssetImage('assets/images/wishlist.png')
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'المفضله',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigateTo(context, CartScreen());
                          },
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    width: 80,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                          image:   AssetImage('assets/images/cart.png')
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'العربه',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    width: 80,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                          image:   AssetImage('assets/images/order.png')
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'طلباتي',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget content(BuildContext context, String text, IconData icon) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
