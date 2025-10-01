

class ApiEndpoints {
   static const String baseUrl = 'http://192.168.1.7:3000';
   // Specific endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String getFacilitators = '$baseUrl/auth/facilitators';
  static const String createGame = '$baseUrl/admin/game-formats';
  static const String createNewSessionFormat = '$baseUrl/admin/player-capability';
  static const String postSessionMethod = '$baseUrl/sessions';
  static const String additionalSetting = '$baseUrl/admin/player-capability';
  static const String scheduleAndActiveSession = '$baseUrl/sessions/all';
  static const String startSession = '$baseUrl/sessions/1/start';
  static const String resumeSession = '$baseUrl/sessions/1/resume';
  static const String pauseSession = '$baseUrl/sessions/1/pause';
  //dynamic endpoints
  //static const String getFacilitators = '$createGame/facilitators';

}

