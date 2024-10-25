import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:zineapp2023/common/navigator.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';

import '../confirm_password_mail.dart';

class PasswordResetVm extends ChangeNotifier {
  final AuthRepo myRepo;

  PasswordResetVm({required this.myRepo});

  String _email = "";

  get email => _email;

  bool loading = false;

  void setLoading(bool v) {
    loading = v;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
  }

  Future<void> sendPasswordReset() async {
    setLoading(true);
    bool showPasswordResetScreen=false;
    try {
        showPasswordResetScreen= await myRepo.sendResetEmail(_email);

      setLoading(false);

        if(showPasswordResetScreen){
        Navigator.of(NavigationService.navigatorKey.currentContext!)
            .pushReplacement(MaterialPageRoute(
                builder: (ctx) => const PasswordResetConfirm()));
      }else
        {
          Fluttertoast.showToast(
              msg: "Error in verifying Account(Please signup)",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red);
        }
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red);
    }
  }
}
