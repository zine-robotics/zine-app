import 'dart:convert';
import 'package:http/http.dart';
import 'package:zineapp2023/backend_properties.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/models/newTask.dart';
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/utilities/custom_logger.dart';

final logger = customLogger();

class TaskInstanceRepo {
  final UserProv userProv;
  String _uid = "";
  TaskInstanceRepo({required this.userProv}) {
    _uid = userProv.getUserInfo.uid!;
  }

  Future<List<UserTaskInstance>> getTaskInstances() async {
    List<UserTaskInstance> taskInstances = [];

    Response res = await http.get(BackendProperties.taskInstanceByIdUri,
        headers: {
          'Authorization': 'Bearer $_uid',
          ...BackendProperties.getHeaders()
        });
    logger.i('Retrieving task instances for user: $_uid');
    logger.d('Response: ${res.body}');

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      Map<String, dynamic> resBody = jsonDecode(res.body);
      var instances = resBody['instances'] as List;
      taskInstances = instances
          .map((instance) => UserTaskInstance(
              instanceId: instance['id'],
              title: instance['name'],
              roomId: 0,
              completionPercentage: instance['completionPercentage'],
              roomName: instance['roomName'],
              status: instance['status'],
              task: UserNewTask.fromJson(
                instance['task'],
              )))
          .toList();

      return taskInstances;
    }

    return [];
  }

  Future<List<Checkpoint>> getCheckpoints(int instanceId) async {
    Response res = await http
        .get(BackendProperties.instanceCheckpointUri(instanceId), headers: {
      'Authorization': 'Bearer $_uid',
      ...BackendProperties.getHeaders()
    });

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      Map<String, dynamic> resBody = jsonDecode(res.body);
      logger.i('Retrieving checkpoints for instance: $instanceId');
      var checkPointJson = resBody['checkpoints'] as List;
      logger.d('Response: ${res.body}');
      return checkPointJson
          .map((checkpoint) => Checkpoint.fromJson(checkpoint))
          .toList();
    }

    return [];
  }

  Future<void> addCheckpoints(String message, int instanceId) async {
    try {
      logger.i('Adding checkpoint for instance: $instanceId');
      Response res =
          await http.post(BackendProperties.addCheckpointUri(instanceId),
              body: jsonEncode({
                "content": message,
                "remark": "false",
                "sentFromId": userProv.getUserInfo.id.toString()
              }),
              headers: {
            'Authorization': 'Bearer $_uid',
            'Content-Type': 'application/json',
            ...BackendProperties.getHeaders()
          });

      if (res.statusCode == 200) {
        logger.i('Checkpoint added successfully');
      } else {
        logger.e("Add checkpoint reponse error with response body ${res.body}");
      }
    } catch (e) {
      logger.e("Add checkpoint error: $e");
    }
  }

  Future<List<Link>> getLinks(int instanceId) async {
    Response res = await http
        .get(BackendProperties.instanceLinksUri(instanceId), headers: {
      'Authorization': 'Bearer $_uid',
      ...BackendProperties.getHeaders()
    });

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      Map<String, dynamic> resBody = jsonDecode(res.body);
      logger.i(resBody);
      var linksJson = resBody['links'] as List;
      return linksJson.map((link) => Link.fromJson(link)).toList();
    }

    return [];
  }

  Future<void> addLinks(String heading, String link, int instanceId) async {
    try {
      Response res =
          await http.post(BackendProperties.addInstanceLinkUri(instanceId),
              body: jsonEncode({
                "type": heading,
                "link": Uri.parse(link).toString(),
                "sentFromId": userProv.getUserInfo.id.toString()
              }),
              headers: {
            'Authorization': 'Bearer $_uid',
            'Content-Type': 'application/json',
            ...BackendProperties.getHeaders()
          });

      if (res.statusCode == 200) {
        logger.i("Link added successfully");
      } else {
        logger.e("Add link response error with response body ${res.body}");
      }
    } catch (e) {
      logger.e("Add link error: $e");
    }
  }
}
