import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: remove this file
class DashRepo {
  Future<List<Map<String, dynamic>>> getEventsDate() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('events').get();

    List<Map<String, dynamic>> eventsList = [];

    for (var doc in querySnapshot.docs) {
      var date = doc.data()['timeDate'];
      //print("date is:${date}");
      // date=getDDMMYY2(date as Timestamp);
      //print('date is :$date');

      eventsList.add({
        'date': date,
      });
    }

    return eventsList;
  }

  Future<void> launchUrlStart({required String url}) async {
    if (url.isEmpty) return;
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
