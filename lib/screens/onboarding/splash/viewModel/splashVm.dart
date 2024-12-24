import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

import '/common/data_store.dart';
import '/common/navigator.dart';
import '/common/routing.dart';
import '/models/user.dart';
import '/providers/user_info.dart';
import '/screens/onboarding/repo/auth_repo.dart';

class SplashVM extends ChangeNotifier {
  final DataStore store;
  final UserProv userProv;
  final AuthRepo authRepo;

  SplashVM(
      {required this.store, required this.userProv, required this.authRepo});

  Future<String> getData(String param) async {
    String? data = await store.getString(param);
    return data.toString();
  }

  Future<void> isLogged(BuildContext context) async {
    String? logged = await store.getString('loggedIn');
    String? uid = await store.getString('uid');

    if (uid != null && logged != null && logged.toString() == 'true') {
      try {
        UserModel currUser = await authRepo.getUserbyId(uid.toString());
        print("check currUser$currUser.");
        userProv.updateUserInfo(currUser);
        await Navigator.of(NavigationService.navigatorKey.currentContext!,
                rootNavigator: true)
            .pushReplacement(Routes.homeScreen());
      } on AuthException {
        await Fluttertoast.showToast(
            msg: 'An Unknown Error Occured', backgroundColor: Colors.red);
        await Navigator.of(NavigationService.navigatorKey.currentContext!,
                rootNavigator: true)
            .pushReplacement(Routes.landingScreen());
      }
    } else {
      await Navigator.of(NavigationService.navigatorKey.currentContext!,
              rootNavigator: true)
          .pushReplacement(Routes.landingScreen());
    }
  }
}
