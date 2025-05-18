import 'dart:convert';
import 'package:zineapp2023/backend_properties.dart';
import 'package:zineapp2023/utilities/custom_logger.dart';
import '../../../models/events.dart';
import 'package:http/http.dart' as http;

final logger = customLogger();

class EventsRepo {
  Future<List<Events>> fetchEvents() async {
    try {
      Uri url = BackendProperties.eventsUri;
      final response =
          await http.get(url, headers: BackendProperties.getHeaders());
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> eventJson = jsonResponse['events'];
        List<Events> events =
            eventJson.map((json) => Events.fromJson(json)).toList();
        return events;
      } else {
        logger.e("Failed to load messages: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      logger.e("An error occurred: $e");
      return [];
    }
  }
}
