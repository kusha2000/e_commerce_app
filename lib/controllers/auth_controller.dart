import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //textcontrollers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  //signup method
  // Future<UserCredential?> signupMethod({email, password, context}) async {
  //   UserCredential? userCredential;

  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }

  //   return userCredential;
  // }

  // //storing data method
  // storeUserData({name, password, email}) async {
  //   DocumentReference store =
  //       firestore.collection(usersCollection).doc(currentUser!.uid);
  //   store.set({
  //     'name': name,
  //     'password': password,
  //     'email': email,
  //     'imageUrl': '',
  //     'id': currentUser!.uid,
  //     'cart_count': "00",
  //     'wishlist_count': "00",
  //     'order_count': "00",
  //   });
  // }

  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
      return null; // Return null if there's an error
    }
  }

//storing data method
  storeUserData({name, password, email}) async {
    // Wait for the signup process to complete and get the user's UID
    await Future.delayed(Duration(
        seconds: 1)); // Add a small delay for the user ID to be available
    User? user = auth.currentUser;
    if (user != null) {
      DocumentReference store =
          firestore.collection(usersCollection).doc(user.uid);
      store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': '',
        'id': user.uid, // Use the same UID as the authentication user ID
        'cart_count': "00",
        'wishlist_count': "00",
        'order_count': "00",
      });
    } else {
      print('User is null. Unable to store user data.');
    }
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
