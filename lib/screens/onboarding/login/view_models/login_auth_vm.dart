import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  Future<void> loginApi(BuildContext context) async {
    Map data = {
      'email': _email.trim(),
      'password': _password.trim(),
    };

    setLoading(true);

    try {
      String pushToken =
          await userProvider.getFirebaseMessagingToken() ?? 'null';
      var value = await myRepo
          .signInWithEmailAndPassword(
              email: data['email'],
              password: data['password'],
              pushToken: pushToken)
          .timeout(
        const Duration(minutes: 1), // Set timeout duration to 1 minute
        onTimeout: () {
          throw TimeoutException('Sign-in request timed out after 1 minute.');
        },
      );
      print(value);
      print("pushTOken:${pushToken}");
      setLoading(false);
      userProvider.updateUserInfo(value!);

      clearValues();

      await Navigator.of(NavigationService.navigatorKey.currentContext!,
              rootNavigator: true)
          .pushAndRemoveUntil(
              Routes.homeScreen(), (Route<dynamic> route) => false);
    } on TimeoutException catch (e) {
      // Handle timeout error
      setLoading(false);
      print('Timeout occurred: ${e.message}');
      Fluttertoast.showToast(
          msg: 'Sign-in request timed out. Please try again.',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red);
    } on AuthException catch (e) {
      switch (e.code) {
        //TODO: ENSURE THAT ERRORS ARE BEING caught here
        case "no-connect":
          errorText = "Connection error. Is your internet working?";
          break;
        case "invalid-email":
          errorText = "Your email address appears to be malformed";
          break;
        case "wrong-password":
          errorText = "Incorrect Password";
          break;
        case "user-not-found":
          errorText = "User Not Found";
          break;
        case "user-disabled":
          errorText = "Account has been disabled";
          break;
        case "too-many-requests":
          errorText = "Please Try Again Later";
          break;
        case "operation-not-allowed":
          errorText = "Please try again later";
          break;
        case "error-sending-email":
          errorText = "Please register yourself again";
          break;
        case "user_not_verified":
          errorText = "Please verify yourself (check your email)";
          break;
        case "user_not_verified_email_resent":
          errorText = "Please verify yourself (check your email)";
          break;
        default:
          errorText = e.code;
        // print("error:${e.toString()}");
      } //     errorText = "Signing in with Email and Password is not enabled";

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
