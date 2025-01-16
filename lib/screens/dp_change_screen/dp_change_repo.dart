import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:zineapp2023/backend_properties.dart';
import 'package:path/path.dart' as path;

class DPUpdateRepo {
  static Future<String?> saveFile({
    required File file,
    String? filename,
    String? directory,
  }) async {
    // Get the app's private directory path
    final Directory appDir = await getApplicationDocumentsDirectory();

    // Create full directory path including optional subdirectory
    String savePath = appDir.path;
    if (directory != null) {
      savePath = path.join(savePath, 'pp', directory);
      // Create subdirectory if it doesn't exist
      final Directory saveDir = Directory(savePath);
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }
    }

    // Use provided filename or extract from original file
    final String saveFilename = filename ?? path.basename(file.path);

    // Create the full save path
    final String filePath = path.join(savePath, saveFilename);

    try {
      // Copy file to new location
      final File savedFile = await file.copy(filePath);
      return savedFile.path;
    } catch (e) {
      return null;
    }
  }

  static Future<Uri?> uploadDP(
      {required File file, required String uid}) async {
    try {
      // Create a MultipartRequest
      var request = http.MultipartRequest(
        'POST',
        BackendProperties.updateDp,
      );

      // Attach the file as form-data
      var multipartFile = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(multipartFile);

      // Attach the description as form-data
      request.fields['delete'] = 'false';

      request.headers.addAll(BackendProperties.getHeaders(uid: uid));

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        // Parse the response
        var responseBody = await http.Response.fromStream(response);
        var responseData = json.decode(responseBody.body);

        if (responseData != null && responseData.containsKey('url')) {
          Uri url = Uri.parse(responseData['url']);
          if (kDebugMode) {
            print("Got File url ${url.toString()}");
          }
          return url;
        } else {
          if (kDebugMode) {
            print('Response does not contain a "url" field');
          }
          return null;
        }
      } else {
        throw Exception(
            'File upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      if (kDebugMode) {
        print('Error uploading file: $e');
      }
      return null;
    }
  }

  static void upload(Function updateDp, String uid, String id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var path2 = result.files.single.path!;
      print("Got Path $path2");
      Uri? fileUri = await uploadDP(file: File(path2), uid: uid);
      if (fileUri == null) {
        Fluttertoast.showToast(
            msg: 'An Error Occured during upload',
            backgroundColor: Colors.red,
            textColor: Colors.white);
        return;
      }

      String? savePath = await saveFile(
          file: File(result.files.single.path!), filename: id.toString());

      if (savePath != null) {
        if (kDebugMode) {
          print("Updating DP $savePath");
        }
        updateDp(savePath);
      }
    }
  }


}
