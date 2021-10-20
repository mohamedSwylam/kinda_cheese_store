
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/modules/Login_screen/login_screen.dart';
import 'package:store_app/modules/sign_up_screen/sign_up_screen.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/styles/colors/colors.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  List<String> images = [
    'https://food2mins.com/wp-content/uploads/2019/04/%D8%B7%D8%B1%D9%8A%D9%82%D8%A9-%D8%B9%D9%85%D9%84-%D8%A7%D9%84%D8%A8%D9%8A%D8%AA%D8%B2%D8%A7-%D8%A7%D9%84%D8%A7%D9%8A%D8%B7%D8%A7%D9%84%D9%8A%D8%A9-%D8%A8%D8%B7%D8%B1%D9%8A%D9%82%D8%A9-%D8%A7%D8%AD%D8%AA%D8%B1%D8%A7%D9%81%D9%8A%D8%A9-2.jpg',
    'https://s3-eu-west-1.amazonaws.com/manalonline.com/upload/articles/*x*_jFpl4uxXv66e7raNO1MG.jpg',
    'https://aldaleelnews.com/wp-content/uploads/2020/09/received_311684563455315.jpeg',
    'https://www.supermama.me/system/App/Entities/Recipe/images/000/105/030/web-watermarked-large/%D8%B7%D8%B1%D9%8A%D9%82%D8%A9-%D8%B9%D9%85%D9%84-%D8%A8%D9%8A%D8%AA%D8%B2%D8%A7-%D8%A8%D9%85%D9%83%D9%88%D9%86%D9%8A%D9%86-%D9%81%D9%82%D8%B7.jpg',
  ];
  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
    CurvedAnimation(parent: _animationController, curve: Curves.linear)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          CachedNetworkImage(
            imageUrl: images[1],
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'مرحبا',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    '   مرحبا بكم في متجرنا كنده تشيز',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: ColorsConsts.backgroundColor),
                              ),
                            )),
                        onPressed: () {
                          navigateTo(context, LoginScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'دخول',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Feather.user,
                              size: 18,
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.pink.shade400),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side:
                                BorderSide(color: ColorsConsts.backgroundColor),
                              ),
                            )),
                        onPressed: () {
                          navigateTo(context, SignUpScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'انشاء حساب',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Feather.user_plus,
                              size: 18,
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),
                  Text(
                    'او يمكنك استخدام',
                    style: TextStyle(color: Colors.black,fontSize: 18),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    color: Colors.blue[900],
                    iconSize: 40,
                    icon: Icon(
                      FontAwesome.facebook_square,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    color: Colors.redAccent,
                    iconSize: 45,
                    icon: Icon(
                      FontAwesome.google_plus_official,
                    ),
                  ),
                  SizedBox(width: 25,),
                  OutlineButton(
                    onPressed: () {},
                    shape: StadiumBorder(),
                    highlightedBorderColor: Colors.deepPurple.shade200,
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                    child: Text('الدخول ك ضيف'),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ]));
  }
}
