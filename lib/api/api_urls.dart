class ApiEndpoints {
  static const String baseUrl = 'http://192.168.1.5:3000';

  // Specific endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String getFacilitators = '$baseUrl/auth/facilitators';
  static const String createGame = '$baseUrl/admin/game-formats';
  static const String createNewSessionFormat = '$baseUrl/admin/player-capability';
  static const String postSessionMethod = '$baseUrl/sessions';
  static const String additionalSetting = '$baseUrl/admin/player-capability';
  static const String scheduleAndActiveSession = '$baseUrl/sessions/all';
  static const String phaseSession = '$baseUrl/phase-session';
  static const String gameFormatPhases = '$baseUrl/questions/session/1/game-format';
  static const String players = '$baseUrl/team/session/1/players';
  static const String viewResponse = '$baseUrl/player-answers/facilitator/1/phase/1';
  static const String submitScore = '$baseUrl/evaluation/evaluate';
  static const String analysis = '$baseUrl/scores/1/analytics';
  static const String userManagementStat = '$baseUrl/user/4/stats';
  static const String facilitatorManagementStat = '$baseUrl/user/1/facilitator-stats';

  // Dynamic endpoints
  // Dynamic session detail endpoint
  static String sessionDetail(int sessionId) =>
      "$baseUrl/sessions/$sessionId/detail";
  static String getStartSessionUrl(int sessionId) => '$baseUrl/sessions/$sessionId/start';
  static String getResumeSessionUrl(int sessionId) => '$baseUrl/sessions/$sessionId/resume';
  static String getPauseSessionUrl(int sessionId) => '$baseUrl/sessions/$sessionId/pause';
  static String getPhaseSessionUrl(int sessionId) => '$baseUrl/sessions/$sessionId/phases';
}