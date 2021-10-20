
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/models/user_model.dart';
import 'package:store_app/modules/sign_up_screen/cubit/states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  File profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SignUpPickedProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(SignUpPickedProfileImageErrorState());
    }
  }
  void uploadProfileImage() {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadPickedProfileImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(UploadPickedProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPickedProfileImageErrorState());
    });
  }

  void userSignUp({
    @required String name,
    @required String password,
    @required String phone,
    @required String email,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password,)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      emit(SignUpSuccessState());
    /*  createUser(
        name: name,
        uId: value.user.uid,
        phone: phone,
        email: email,
      );*/
    }).catchError((error) {
      emit(SignUpErrorState(error.toString()));
    });
  }

  void createUser({
    String name,
    String uId,
    String phone,
    String email,
    String password,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      password: password,
    //  profileImage: 'https://www.iconsdb.com/icons/preview/light-gray/user-2-xxl.png',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SignUpPasswordVisibilityState());
  }
}
