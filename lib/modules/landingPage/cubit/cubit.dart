import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:store_app/modules/Login_screen/cubit/states.dart';
import 'package:store_app/modules/landingPage/cubit/states.dart';

class LandingPageCubit extends Cubit<LandingPageStates>  {
  LandingPageCubit() : super(LandingPageInitialState());
  static LandingPageCubit get(context) => BlocProvider.of(context);
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
    images.shuffle();
    _animationController =
        AnimationController(vsync: this,duration: Duration(seconds: 20));
    _animation =
    CurvedAnimation(parent: _animationController, curve: Curves.linear)
      ..addListener(() {
        emit(CurvedAnimationSuccessState());
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

}
