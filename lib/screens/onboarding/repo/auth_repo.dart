import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/backend_properties.dart';
import 'package:zineapp2023/database/database.dart';
import 'package:zineapp2023/models/newUser.dart';
import '/common/data_store.dart';
import '../../../models/user.dart';

class AuthRepo {
  // final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  AppDb db;
  late DataStore store;

  AuthRepo({required this.store, required this.db});

  Future<bool> sendResetEmail(String email) async {
    Response res = await http.post(
        BackendProperties.resetUri
            .replace(queryParameters: {'email': email.toString()}),
        headers: BackendProperties.getHeaders());
    print("res:${res.statusCode}");
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> updateToken()
  // {
  //   //TODO: Implement this

  // }

  Future<UserModel?> signInWithEmailAndPassword(
      {String? email, String? password, String? pushToken}) async {
    // String toastText = 'An Undefined Error Occured';

    try {
      Response res = await http.post(BackendProperties.loginUri,
          body: jsonEncode(
              {"email": email, "password": password, "pushToken": pushToken}),
          headers: {
            "Content-Type": "application/json",
            ...BackendProperties.getHeaders()
          });
      Map<String, dynamic> resBody = jsonDecode(res.body);
      if (kDebugMode) {
        print("Reponse Code ${res.statusCode}");
      }
      String userToken = "";
      switch (res.statusCode) {
        case 403:
          if ((resBody['failureReason'] as String) ==
                  'user_not_verified_email_resent' ||
              (resBody['failureReason'] as String) == 'user_not_verified') {
            throw AuthException(code: resBody['failureReason']);
          }

          throw AuthException(code: '403 Error');

        case 429:
          throw AuthException(code: 'too-many-requests');
        case 400:
          if ((resBody['failureReason'] as String) == 'wrong-password') {
            throw AuthException(code: 'wrong-password');
          }
          if ((resBody['failureReason'] as String) == "user-not-found") {
            throw AuthException(code: "user-not-found");
          }
          throw AuthException(code: 'unknown');
        case 200:
          if (!resBody.containsKey('jwt')) {
            throw AuthException(code: 'backend-not-responding');
          } else {
            userToken = (resBody['jwt'] as String);
            print("userToken:${userToken}");
          }
          break;

        default:
          if (resBody.containsKey('failureReason')) {
            throw AuthException(code: resBody['failureReason'].toString());
          }

          throw AuthException(code: 'unknown');
      }

      return getUserbyId(userToken);
    } on SocketException {
      if (kDebugMode) print('no-connect');
      throw AuthException(code: 'no-connect');
    } catch (e) {
      throw AuthException(code: 'unknown');
    }
  }

  Future<bool> isUserReg(String email) async {
    //FIXME : Implement This
    return true;
  }

  Future<UserModel> getUserbyId(String uid) async {
    try {
      Response res = await http.get(BackendProperties.userInfoUri, headers: {
        'Authorization': 'Bearer $uid',
        ...BackendProperties.getHeaders()
      });

      if (res.statusCode != 200 || res.body.isEmpty) throw Exception();
      print('User Body ${res.body}');
      Map<String, dynamic> user = jsonDecode(res.body);
      NewUserModel userData = NewUserModel.fromJson(user);
      await db.upsertUserDB(userData);
      
      UserModel userMod = UserModel(
          uid: uid,
          id: user['id'],
          email: user['email'],
          name: user['name'],
          dp: user['dpUrl'] ?? "1",
          type: user['type'],
          registered: user['registered']! ?? false,
          tasks: [],
          lastSeen: user['lastSeen'] ?? {});

      return userMod;
    } on TimeoutException {
      throw AuthException(code: 'no-connect');
    } catch (e) {
      if (kDebugMode) print("Non TimeoutException Error in GetUserByID");
      throw AuthException(code: 'unknown');
    }
  }

  Future<UserModel?> createUserWithEmailAndPassword({
    String name = 'New Recruit',
    String email = 'a@gmail.com',
    String password = 'password',
  }) async {
    try {
      Response res = await http.post(BackendProperties.registerUri,
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
          }),
          headers: {
            "Content-Type": "application/json",
            ...BackendProperties.getHeaders()
          });

      switch (res.statusCode) {
        case 409: //TODO: ADD COMMON CASES
          throw AuthException(code: 'email-already-in-use');

        default:
      }
      return UserModel();
    } on SocketException {
      throw AuthException(code: 'no-connect');
    } catch (e) {
      throw AuthException(code: 'unknown');
    }
  }

  Future<void> signOut() async {
    // await _firebaseAuth.signOut();
    store.delete(key: 'uid');
    store.setString('loggedIn', 'true');
  }
}

class AuthException implements Exception {
  String code;

  AuthException({required this.code});
}
