import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool obscure = true;
  IconData prefix = Icons.visibility;

  void changeVisibility() {
    obscure = !obscure;
    prefix = obscure
        ? prefix = Icons.visibility
        : prefix = Icons.visibility_off_outlined;
    emit(RegisterChangeVisibilityState());
  }

  //Register with email and password
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterCreateUserLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async{
      var token = await FirebaseMessaging.instance.getToken();
      createUser(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone ,
        image: 'https://media.istockphoto.com/vectors/default-user_profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
        coverImage:
        'https://edufolios.org/sebastiaansterel/wp-content/themes/edufolios/images/defaults/default-cover.gif',
        bio: 'bio...',
        token: token??''
      );
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserErrorState());
    });
  }

  //Register with Google Account
  void registerWithGoogle() async {
    emit(RegisterGoogleAccountLoadingState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async{
      var token = await FirebaseMessaging.instance.getToken();
      createUser(
        uId: value.user!.uid,
        name: value.user!.displayName ?? 'User Name',
        email: value.user!.email ?? 'email...!',
        phone: value.user!.phoneNumber ?? 'phone ...!',
        image: value.additionalUserInfo!.profile!['picture'] ??
            'https://media.istockphoto.com/vectors/default-user_profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
        coverImage:
        'https://edufolios.org/sebastiaansterel/wp-content/themes/edufolios/images/defaults/default-cover.gif',
        bio: 'bio...',
        token: token??''
      );
      emit(RegisterGoogleAccountSuccesState());
    }).catchError((error) {
      emit(RegisterGoogleAccountErrorState());
    });
  }

  //Create Users
  void createUser({
    required String uId,
    required String name,
    required String email,
    required String phone,
    required String image,
    required String coverImage,
    required String bio,
    required String token,
  }) {
    UserModel userModel = UserModel(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      image: image,
      coverImage: coverImage,
      bio: bio,
      token: token
    );
    print('name: ${userModel.name}');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccesState(uId));
    }).catchError((error) {
      emit(RegisterCreateUserErrorState());
    });
  }
}
