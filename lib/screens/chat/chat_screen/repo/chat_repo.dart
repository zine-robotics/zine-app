import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:win32/win32.dart';
import 'package:zineapp2023/backend_properties.dart';
import 'package:zineapp2023/database/database.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/models/newUser.dart';

import '../../../../models/events.dart';
import '../../../../models/rooms.dart';
import '../../../../models/user.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class ChatRepo {
//=====================================================NEWER CODE================================================================//

//------------------------------------Fetching_all_messages_through_RoomId-------------------------------------------//
  Future<List<MessageModel>> getChatMessages(String tempRoomId) async {
    try {
      Uri url = BackendProperties.roomMessageUri(tempRoomId);
      final response =
          await http.get(url, headers: BackendProperties.getHeaders());
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        // logger.d(jsonResponse);
        List<MessageModel> messages = jsonResponse
            .where((json) => json != null && json is Map<String, dynamic>)
            .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return messages;
      } else {
        logger.w("Failed to load messages: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  //---------------------------------Fetching_Rooms_Details-----------------------//

  Future<List<Rooms>?> fetchRooms(String email) async {
    Uri url = BackendProperties.roomDataUri(email);
    // 'http://172.20.10.4:8080/rooms/user'
    //     '?email=$email';
    final response =
        await http.get(url, headers: BackendProperties.getHeaders());

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Rooms> roomData =
          jsonResponse.map((json) => Rooms.fromJson(json)).toList();
      // roomData.forEach((room) {
      //   print("Room ID: ${room.id}");
      //   print("Room Name: ${room.name}");
      //   print("Room Description: ${room.description}");
      //   print("Room Type: ${room.type}");
      //   print("Room DP URL: ${room.dpUrl}");
      //   print("Timestamp: ${room.timestamp}");
      //   print("Last Message Timestamp: ${room.lastMessageTimestamp}");
      //   print("Unread Messages: ${room.unreadMessages}");
      //   print("User Last Seen: ${room.userLastSeen}");
      //   print("=====================================");
      // });
      return roomData;
    } else {
      print("failed to load the rooms info :${response.statusCode}");
      return [];
    }
  }

  //---------------------------------Announcement_details----------------------------//
  Future<List<Rooms>> fetchAnnouncement(String emailId) async {
    // print("inside Announcement");
    List<Rooms> announcements = [];
    try {
      Uri url = BackendProperties.announcementUri(emailId);
      final response =
          await http.get(url, headers: BackendProperties.getHeaders());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('announcementRoom')) {
          final Map<String, dynamic> announcement =
              responseData['announcementRoom'];
          print("\n\nannouncement data as:${announcement}");
          Rooms announcement1 = Rooms.fromJson(announcement);
          announcements.add(announcement1);
        }
      }
    } catch (e) {
      print("An error occurred while fetching announcement: $e");
    }
    return announcements;
  }

  //--------------------------------check LastSeen----------------------------------//
  Future<LastSeen?> fetchLastSeen(String emailId, String roomId) async {
    // print("inside fetchLastSeen");
    // print("email: $emailId and roomId: $roomId");

    try {
      Uri url = BackendProperties.lastSeenUri(emailId, roomId);
      final response =
          await http.get(url, headers: BackendProperties.getHeaders());

      print("response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('info')) {
          final Map<String, dynamic> info = responseData['info'];
          return LastSeen.fromJson(info);
        } else {
          // print("Key 'info' not found in response.");
          return null;
        }
      } else {
        // print("Failed to load the rooms info: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

//-------------------------------total activememeber subscribe to same room---------------------//
  Future<List<RoomMemberModel>> fetchTotalActiveMember(String roomId) async {
    try {
      Uri url = BackendProperties.activeMemberUri(roomId);
      final response =
          await http.get(url, headers: BackendProperties.getHeaders());

      if (response.statusCode == 200) {
        List<dynamic> users = jsonDecode(response.body);
        List<RoomMemberModel> members =
            users.map((json) => RoomMemberModel.fromJson(json)).toList();
        return members;
      } else {
        print("Failed to load users, status code: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("Error occurred while fetching users: $error");
      return [];
    }
  }
}
