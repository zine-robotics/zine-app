import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/backend_properties.dart';
import 'package:zineapp2023/database/database.dart';
import 'package:zineapp2023/models/newUser.dart';
import 'package:zineapp2023/screens/chat/chat_screen/repo/chat_repo.dart';
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
    Response res;
    Map<String, dynamic> resBody = {};
    try {
      res = await http.post(BackendProperties.loginUri,
          body: jsonEncode(
              {"email": email, "password": password, "pushToken": pushToken}),
          headers: {
            "Content-Type": "application/json",
            ...BackendProperties.getHeaders()
          });
      resBody = jsonDecode(res.body);
      logger.i(resBody);
      if (kDebugMode) {
        print("Reponse Code ${resBody['failureReason']}");
      }

      String userToken = "";
      switch (res.statusCode) {
        case 200:
          if (!resBody.containsKey('jwt')) {
            throw AuthException(code: 'backend-not-responding');
          } else {
            userToken = (resBody['jwt'] as String);
            print("userToken:${userToken}");
            return getUserbyId(userToken);
          }
          break;

        default:
          print("${resBody['failureReason']}");
          throw AuthException(code: resBody['failureReason']);
      }
    } on SocketException {
      if (kDebugMode) print('no-connect');
      throw AuthException(code: 'no-connect');
    } catch (e) {
      print("Error in SignInWithEmailAndPassword");
      throw AuthException(code: resBody['failureReason']);
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

  Future<void> createUserWithEmailAndPassword({
    String name = 'New Recruit',
    String email = 'a@gmail.com',
    String password = 'password',
  }) async {
    Map<String, dynamic> resBody = {};
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
      resBody = jsonDecode(res.body);
      logger.i(jsonDecode(res.body));
      switch (res.statusCode) {
        case 200:
          logger.i(jsonDecode(res.body));
          return;
        default:
          throw AuthException(code: resBody['message']);
      }
    } on SocketException {
      print("Exception in createUserWithEmailAndPassword");
      throw AuthException(code: 'no-connect');
    } catch (e) {
      print("Exception in createUserWithEmailAndPassword");
      throw AuthException(code: resBody['message']);
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
