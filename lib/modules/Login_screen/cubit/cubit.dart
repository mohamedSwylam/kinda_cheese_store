import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/models/user_model.dart';
import 'package:store_app/modules/Login_screen/cubit/states.dart';
import 'package:store_app/shared/constants/constant.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String password,
    @required String email,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password).then((value){
          getUserData();
          getOrders();
          print(value.user.email);
          print(value.user.uid);
     emit(LoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityState());
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  String phone;
  String email;
  String uId;
  String profileImage;
  String address;
  String joinedAt;
  String createdAt;
  void getUserData() async {
    emit(GetUserLoginLoadingStates());
    User user = _auth.currentUser;
    uId = user.uid;
    print('user.displayName ${user.displayName}');
    print('user.photoURL ${user.photoURL}');
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uId).get();
    if (userDoc == null) {
      return;
    } else {
        name = userDoc.get('name');
        email = user.email;
        joinedAt = userDoc.get('joinedAt');
        phone = userDoc.get('phone');
        address = userDoc.get('address');
        profileImage = userDoc.get('profileImage');
        createdAt = userDoc.get('createdAt');
        emit(GetUserLoginSuccessStates());
    }
  }
  List<OrderModel> orders = [];
  void getOrders() async {
    emit(GetOrdersLoadingStates());
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uId)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      orders.clear();
      ordersSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            title: element.get('title'),
            price: element.get('price'),
            imageUrl: element.get('imageUrl'),
            userId: element.get('userId'),
            userAddress: element.get('userAddress'),
            total: element.get('total'),
            subTotal: element.get('subTotal'),
            anotherNumber: element.get('anotherNumber'),
            addressDetails: element.get('addressDetails'),
            quantity: element.get('quantity'),
            productId: element.get('productId'),
            username: element.get('username'),
            userPhone: element.get('userPhone'),
          ),
        );
      });
      emit(GetOrdersSuccessStates());
    }).catchError((error) {
      emit(GetOrdersErrorStates());
    });
  }
  }

