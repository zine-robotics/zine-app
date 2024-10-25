import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

List<String> months = [
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MAY',
  'JUN',
  'JUL',
  'AUG',
  'SEP',
  'OCT',
  'NOV',
  'DEC'
];

//===============================Newer CODE=========================================//
bool isPastEvent(int timeStamp) {
  DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  DateTime today = DateTime.now();
  DateTime eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
  DateTime todayDate = DateTime(today.year, today.month, today.day);

  return eventDay.isBefore(todayDate);  // Returns true if the event is in the past
}

DateTime convertTimestamp(int timestamp) {
  if (timestamp > 1000000000) {
    // Convert from milliseconds
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  } else {
    // Convert from seconds
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}

String getChatTime(int timeStamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return '${dateTime.hour}:${dateTime.minute >= 10 ? dateTime.minute : '0${dateTime.minute}'}';
}

String getChatDate(int timeStamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  return '${months[dateTime.month - 1]}';
}

String validShowDate(int timeStamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

  return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
}

String getLastSeenFormat(int timeStamp) {
  try {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    DateTime now = DateTime.now();

    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));

    if (dateTime.isAfter(today)) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (dateTime.isAfter(yesterday)) {
      return 'Yesterday';
    } else {
      return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString().substring(2)}';
    }
  } catch (e) {
    return "";
  }
}

//================================Older CODE========================================//

String getTime(Timestamp timeStamp) {
  return '${timeStamp.toDate().hour}:${timeStamp.toDate().minute >= 10 ? timeStamp.toDate().minute : '0${timeStamp.toDate().minute}'}';
}

String getDate(Timestamp timeStamp) {
  return '${months[timeStamp.toDate().month - 1]}';
}

String getDay(Timestamp timeStamp) {
  return '${timeStamp.toDate().day} ';
}

String getYear(Timestamp timeStamp) {
  return '${timeStamp.toDate().year} ';
}

List<int> getDMY(Timestamp tmp) {
  return [tmp.toDate().day, tmp.toDate().month, tmp.toDate().year];
}

String getDDMMYY(Timestamp timeStamp) {
  return '${timeStamp.toDate().year},${timeStamp.toDate().month - 1},${timeStamp.toDate().day}';
}

String getDDMMYY2(Timestamp timeStamp) {
  return '${timeStamp.toDate().year},${timeStamp.toDate().month},${timeStamp.toDate().day}';
}

String getDDate(DateTime dt) {
  return '${new DateFormat("yyyy-MM-dd").format(dt)}';
}
