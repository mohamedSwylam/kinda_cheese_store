import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/modules/feeds.dart';
import 'package:store_app/modules/home.dart';
import 'package:store_app/modules/user.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class StoreLayout extends StatefulWidget {
  @override
  _StoreLayoutState createState() => _StoreLayoutState();
}

class _StoreLayoutState extends State<StoreLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreAppCubit.get(context).pages[StoreAppCubit.get(context).selectedIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: kBottomNavigationBarHeight*0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: .05,color: Colors.grey),
              ),
            ),
            child: BottomNavigationBar(
              onTap: StoreAppCubit.get(context).selectedPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.teal,
              currentIndex: StoreAppCubit.get(context).selectedIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Feather.home), tooltip: 'Home', label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Feather.rss), tooltip: 'Feed', label: 'Feed'),
                BottomNavigationBarItem(
                    icon: Icon(null), tooltip: 'Search', label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(MaterialCommunityIcons.cart), tooltip: 'Cart', label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Feather.user), tooltip: 'User', label: 'User'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          tooltip: 'Search',
          elevation: 4,
          hoverElevation: 10,
          splashColor: Colors.grey,
          backgroundColor: Colors.teal,
          child: Icon(Icons.search),
          onPressed: StoreAppCubit.get(context).selectedSearch,
        ),
      ),
    );
  }
}
