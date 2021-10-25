
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:store_app/layout/store_layout.dart';
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
    'https://www.mobiles.co.uk/blog/content/images/size/w2000/2019/09/banner-3.jpg',
    'https://www.mobiles.co.uk/blog/content/images/2019/09/design-2.jpg',
    'https://www.mactrast.com/wp-content/uploads/2018/09/Apple-iPhone-Xs-combo-gold-banner.jpg',
    'https://etgeekera.files.wordpress.com/2016/09/iphone-7-banner.jpg',
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          navigateTo(context, StoreLayout());
        } catch (error) {
          authErrorHandle(error.message, context);
        }
      }
    }
  }
  Future<void> authErrorHandle(String subtitle, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Image.network(
                    'https://image.flaticon.com/icons/png/128/564/564619.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Error occured'),
                ),
              ],
            ),
            content: Text(subtitle),
            actions: [

              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
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
                    '   مرحبا بكم في متجر بركات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.grey,
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
                    onPressed: () {
                      _googleSignIn();
                    },
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
