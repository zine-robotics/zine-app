import 'dart:convert';
import 'package:zineapp2023/backend_properties.dart';
import '../../../models/events.dart';
import 'package:http/http.dart' as http;

class EventsRepo {
  //==================================================NEWER CODE=======================================//
  Future<List<Events>> fetchEvents() async {
    try {
      Uri url = BackendProperties.eventsUri;
      final response = await http.get(url,headers: BackendProperties.getHeaders());
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> eventJson = jsonResponse['events'];
        List<Events> events =
            eventJson.map((json) => Events.fromJson(json)).toList();
        // print("inside the chat_repo and message:${events.toList()}");
        return events;
      } else {
        print("Failed to load messages: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("An error occurred: $e");
      return [];
    }
  }
}
