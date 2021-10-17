import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:store_app/layout/cubit/cubit.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/modules/cart_screen.dart';
import 'package:store_app/modules/wishlist_screen.dart';
import 'package:store_app/shared/components/components.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ScrollController _scrollController;
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Icon(
                MaterialCommunityIcons.cart,
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 11),
                child: Text(
                  'الحساب',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                expandedHeight: 100,
                toolbarHeight: 70,
                flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.tealAccent,
                                Colors.green[100],
                              ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                                    radius: 35,
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'مرحبا',
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    'mohamed',
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              navigateTo(context, WishListScreen());
                            },
                            child: Column(
                              children: [
                                Icon(MaterialCommunityIcons.heart,size: 60,color: Colors.teal,),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'المفضله',
                                  style:Theme.of(context).textTheme.bodyText1,
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
                                Icon(MaterialCommunityIcons.cart,size: 60,color: Colors.teal,),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'العربه',
                                  style:Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Icon(MaterialCommunityIcons.basket,size: 60,color: Colors.teal,),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'طلباتي',
                                  style:Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                      ),
                      userTitle(title: 'معلومات المستخدم'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'البريد الالكتروني',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      'mohamedswylam@gmail.com',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.email),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'رقم الهاتف',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      '01098570050',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.phone),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'عنوان الشحن',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      'سبك الاحد اشمون منوفيه',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.local_shipping),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'تاريخ الانضمام',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      '20.2.2021',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.watch_later),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.grey,
                      ),
                      userTitle(title: 'الاعدادات'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              WeatherIcons.wi_day_sunny,
                            ),
                            onPressed: () {
                              StoreAppCubit.get(context).changeThemeModeToLight();
                            },
                            alignment: AlignmentDirectional.center,
                            iconSize: 50,
                          ),
                          IconButton(
                            icon: Icon(
                              WeatherIcons.wi_solar_eclipse,
                            ),
                            alignment: AlignmentDirectional.center,
                            iconSize: 50,
                            onPressed: () {
                              StoreAppCubit.get(context).changeThemeModeToDark();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      /*ListTileSwitch(
                        value: false,
                        leading: Icon(Ionicons.md_moon),
                        onChanged: (value) {
                          setState(() {
// themeChange.darkTheme = value;
                          });
                        },
                        visualDensity: VisualDensity.comfortable,
                        switchType: SwitchType.cupertino,
                        switchActiveColor: Colors.indigo,
                        title: Text('Dark theme'),
                      ),*/
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          child: ListTile(
                            onTap: () async {
// Navigator.canPop(context)? Navigator.pop(context):null;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(right: 6.0),
                                            child: Image.network(
                                              'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Sign out'),
                                          ),
                                        ],
                                      ),
                                      content: Text('Do you wanna Sign out?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {},
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(color: Colors.red),
                                            ))
                                      ],
                                    );
                                  });
                            },
                            title: Center(child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: RaisedButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(color: Colors.redAccent),
                                ),
                                color: Colors.redAccent,
                                child: Text(
                                  'تسجيل الخروج',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).textSelectionColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down

        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down

        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }
  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];
}
