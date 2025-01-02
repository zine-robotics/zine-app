class Environment {
  static const String stage = 'test'; // Change to 'prod'||'test' for production
}
class BackendProperties {
  static Uri baseUrl = Uri(
      scheme: 'https',
      host: 'zine-backend.ip-ddns.com');// https://zinebackend-2b7b.onrender.com //'ec2-18-116-38-241.us-east-2.compute.amazonaws.com'
  // host: '172.20.10.4',
  // port: 8080,
  // );
  static Map<String, String> getHeaders() {
    return {
      'stage': Environment.stage, // Add the stage header
    };
  }

  static Uri resetUri = baseUrl.replace(path: '/auth/forgot');
  static Uri loginUri = baseUrl.replace(path: '/auth/login');
  static Uri userInfoUri = baseUrl.replace(path: '/auth/me');
  static Uri registerUri = baseUrl.replace(path: '/auth/register');

  static Uri roomDataUri(String email) =>
      baseUrl.replace(path: '/rooms/user', queryParameters: {'email': email});

  static Uri allRoomDataUri = baseUrl.replace(path: '/rooms/get-all');
  static Uri roomMessageUri(String tempRoomId) => baseUrl.replace(
      path: 'messages/roomMsg', queryParameters: {'roomId': tempRoomId});

  static Uri allTasksUri = baseUrl.replace(path: '/tasks');
  static Uri taskInstanceByIdUri = baseUrl.replace(path: '/tasks/user');

  static Uri taskDetailUri(String taskId) =>
      baseUrl.replace(path: '/tasks/$taskId');

  static Uri instanceCheckpointUri(int instanceId) => // getting all checkpoints and updating checkpoints is done on the same URI.
      baseUrl.replace(path: '/instance/$instanceId/checkpoints');
  static Uri addCheckpointUri(int instanceId) => // getting all checkpoints and updating checkpoints is done on the same URI.
      baseUrl.replace(path: '/instance/$instanceId/checkpoints');

  static Uri instanceLinksUri(int instanceId) =>
      baseUrl.replace(path: '/instance/$instanceId/links');
  static Uri addInstanceLinkUri(int instanceId) =>
      baseUrl.replace(path: '/instance/$instanceId/links');

  static Uri eventsUri = baseUrl.replace(path: '/event');
  static Uri websocketUri = baseUrl.replace(scheme: 'https',path: '/ws',port: 443);
  static Uri lastSeenUri(String emailId, String roomId) =>
      baseUrl.replace(path: '/user/$emailId/$roomId/last-seen');

  static Uri activeMemberUri(String roomId) => baseUrl
      .replace(path: '/members/get', queryParameters: {"roomId": roomId});

  static Uri updateLastSeenUri(String emailId, String roomId) {
    return baseUrl.replace(path: '/user/$emailId/$roomId/seen');
  }

  static Uri announcementUri(String emailId) => baseUrl
      .replace(path: 'rooms/announcement', queryParameters: {'email': emailId});
}
