import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../providers/user_info.dart';
import '../../../../common/navigator.dart';
import '../../../../common/routing.dart';
import '../../../../models/user.dart';
import '../../repo/auth_repo.dart';

class LoginAuthViewModel with ChangeNotifier {
  final AuthRepo myRepo;
  final UserProv userProvider;

  LoginAuthViewModel({required this.myRepo, required this.userProvider});

  String errorText = "";

  String _email = "";
  String _password = "";

  get email => _email;

  get password => _password;

  setEmail(String value) {
    _email = value;
  }

  setPassword(String value) {
    _password = value;
  }

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void toggleVisible() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void clearValues() {
    _email = "";
    _password = "";
  }

  Future<void> postDetailsToFirestore(UserModel userModel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection("users")
        .doc(userModel.uid)
        .set(userModel.toJson());
  }

  Future<void> loginApi(BuildContext context) async {
    Map data = {
      'email': _email.trim(),
      'password': _password.trim(),
    };

    setLoading(true);

    try {
      String pushToken =
          await userProvider.getFirebaseMessagingToken() ?? 'null';
      var value = await myRepo.signInWithEmailAndPassword(
          email: data['email'],
          password: data['password'],
          pushToken: pushToken);
      print(value);
      userProvider.updateUserInfo(value!);

      setLoading(false);

      clearValues();

      await Navigator.of(NavigationService.navigatorKey.currentContext!,
              rootNavigator: true)
          .pushAndRemoveUntil(
              Routes.homeScreen(), (Route<dynamic> route) => false);
    } on AuthException catch (e) {
      switch (e.code) {
        //TODO: ENSURE THAT ERRORS ARE BEING caught here
        case "invalid-email":
          errorText = "Your email address appears to be malformed";
          break;
        case "wrong-password":
          errorText = "Your password is wrong";
          break;
        case "user-not-found":
          errorText = "User with this email doesn't exist";
          break;
        case "user-disabled":
          errorText = "User with this email has been disabled";
          break;
        case "too-many-requests":
          errorText = "Too many requests";
          break;
        case "operation-not-allowed":
          errorText = "Signing in with Email and Password is not enabled";
          break;
        case "quota-exceeded":
          errorText = "Quota Exceeded. Please contact Team Zine.";
          break;
        case "timeout":
          errorText = "Timeout. Please check you internet and try again later";
          break;
          case "error-sending-email":
          errorText = "Please re-registered yourself";
          break;
        case "user_not_verified":
          errorText = "Please verify your email and login";
          break;
          case "user_not_verified_email_resent":
          errorText = "Please verify yourself (check your email)";
          break;
        default:
          print(
              "Errors are probably not being proccessed probably. Check login_auth_vm.dart");
          errorText = "An undefined Error happened";
          // print("error:${e.toString()}");
      }
      setLoading(false);

      Fluttertoast.showToast(
          msg: errorText,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red);
    }



  }
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }


}
