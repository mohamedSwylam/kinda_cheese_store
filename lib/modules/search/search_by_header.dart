import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/modules/user.dart';
import 'package:store_app/modules/wishlist_screen.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

import '../cart_screen.dart';

class SearchByHeader extends SliverPersistentHeaderDelegate {
  final double flexibleSpace;
  final double backGroundHeight;
  final double stackPaddingTop;
  final double titlePaddingTop;
  final Widget title;
  final Widget subTitle;
  final Widget leading;
  final Widget action;
  final Widget stackChild;

  SearchByHeader({
    this.flexibleSpace = 250,
    this.backGroundHeight = 200,
    @required this.stackPaddingTop,
    this.titlePaddingTop = 35,
    @required this.title,
    this.subTitle,
    this.leading,
    this.action,
    @required this.stackChild,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var percent = shrinkOffset / (maxExtent - minExtent);
    double calculate = 1 - percent < 0 ? 0 : (1 - percent);
    return SizedBox(
      height: maxExtent,
      child: Stack(
        children: <Widget>[
          Container(
            height: minExtent + ((backGroundHeight - minExtent) * calculate),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.tealAccent,
                    Colors.green[100],
                  ],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),

          ),
          Positioned(
            top: 30,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Badge(
                  badgeColor: Colors.teal,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  position: BadgePosition.topEnd(top: 0,end: 0),
                  badgeContent: Text(StoreAppCubit.get(context).carts.length.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                  child: IconButton(
                    onPressed: () {
                      navigateTo(context, CartScreen());
                    },
                    icon: Icon(
                      MaterialCommunityIcons.cart,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding (
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Badge(
                    badgeColor: Colors.teal,
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    position: BadgePosition.topEnd(top: 0,end: 0),
                    badgeContent: Text(StoreAppCubit.get(context).wishList.length.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context, WishListScreen());
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        size: 25,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32,
            left: 10,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade300,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                splashColor: Colors.grey,
                onTap: () => navigateTo(context, UserScreen()),
                child: Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.35,
            top: titlePaddingTop * calculate + 27,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  leading ?? SizedBox(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Transform.scale(
                        alignment: Alignment.centerLeft,
                        scale: 1 + (calculate * .5),
                        child: Padding(
                          padding: EdgeInsets.only(top: 14 * (1 - calculate)),
                          child: title,
                        ),
                      ),
                      if (calculate > .5) ...[
                        SizedBox(height: 10),
                        Opacity(
                          opacity: calculate,
                          child: subTitle ?? SizedBox(),
                        ),
                      ]
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(top: 14 * calculate),
                    child: action ?? SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: minExtent + ((stackPaddingTop - minExtent) * calculate),
            child: Opacity(
              opacity: calculate,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: stackChild,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => flexibleSpace;

  @override
  double get minExtent => kToolbarHeight + 25;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
