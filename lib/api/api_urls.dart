class ApiEndpoints {
  static const String baseUrl = 'http://localhost:3000';

  // -------------------- AUTH --------------------
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String getFacilitators = '$baseUrl/auth/facilitators';
  static const String users = '$baseUrl/auth/users';

  // -------------------- ADMIN --------------------
  static const String createGame = '$baseUrl/admin/game-formats';
  static const String gameModelS = '$baseUrl/admin/game-formats/all-games';
  static const String getPhase = '$baseUrl/admin/phases';

  // -------------------- QUESTIONS --------------------
  static const String aiGenerate = '$baseUrl/questions/generate';
  static String questionsForSession(int sessionId, int gameFormatId) =>
      '$baseUrl/questions/questions-for-session/$sessionId/$gameFormatId';

  // -------------------- TEAM --------------------
  static const String createTeam = '$baseUrl/team/create';
  static String teamsForSession(int sessionId) =>
      '$baseUrl/team/session/$sessionId/members';

  // -------------------- SESSIONS --------------------
  static const String allSessions = '$baseUrl/sessions/with-code';
  static const String joinSession = '$baseUrl/sessions/join';
  static String sessionDetail(int sessionId) =>
      '$baseUrl/sessions/$sessionId/detail';

  // -------------------- PLAYER ANSWERS --------------------
  static const String submitPlayerAnswer = '$baseUrl/player-answers/submit';

  // -------------------- PLAYER SCORES --------------------
  static String playerScore(int playerId, int questionId) =>
      '$baseUrl/scores/player/$playerId/question/$questionId';
  static const String playerScoreUrl = '$baseUrl/scores/player';

  // -------------------- LEADERBOARD --------------------
  static String playerLeaderboard(int sessionId) =>
      '$baseUrl/scores/ranking/session/$sessionId';
  static String teamLeaderboard(int sessionId) =>
      '$baseUrl/scores/ranking/sessions/$sessionId';

// Note: Team leaderboard session ID is fixed to 1 (as per your comment)
}
