import 'package:get/get.dart';
import 'dart:developer' as developer;
import '../../shared_preferences/shared_preferences.dart';
import '../api_models/session_detail_model.dart';
import '../api_services/session_service.dart';

class SessionController extends GetxController {
  var isLoading = true.obs;
  var session = Rxn<SessionModel>();

  final SessionService _sessionService = SessionService();

  @override
  void onInit() {
    super.onInit();
    initializeSession();
  }

  Future<void> initializeSession() async {
    try {
      isLoading(true);

      final sessionId = await SharedPrefServices.getSessionId();
      developer.log('Stored session ID: $sessionId', name: 'SessionController');

      if (sessionId != null) {
        await fetchSession(sessionId);
      } else {
        developer.log('No session ID found in storage', name: 'SessionController');
        isLoading(false);
      }
    } catch (e) {
      developer.log('Error initializing session: $e', name: 'SessionController');
      isLoading(false);
    }
  }

  Future<void> fetchSession(int sessionId) async {
    try {
      isLoading(true);
      developer.log('Fetching session with ID: $sessionId', name: 'SessionController');

      final result = await _sessionService.fetchSessionDetail(sessionId);
      if (result != null) {
        session.value = result;
        developer.log('Session loaded successfully: ${result.teamTitle}', name: 'SessionController');

        await SharedPrefServices.saveSessionId(result.id);
        developer.log('💾 Saved sessionId=${result.id}', name: 'SessionController');
      } else {
        developer.log('Failed to load session - API returned null', name: 'SessionController');
        session.value = null;
      }
    } catch (e) {
      developer.log('Error in fetchSession: $e', name: 'SessionController');
      session.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveAndFetchSession(int sessionId) async {
    await SharedPrefServices.saveSessionId(sessionId);
    developer.log('Session ID saved: $sessionId', name: 'SessionController');
    await fetchSession(sessionId);
  }

  Future<void> refreshSession() async {
    final sessionId = await SharedPrefServices.getSessionId();
    if (sessionId != null) {
      await fetchSession(sessionId);
    } else {
      developer.log('Cannot refresh - no session ID available', name: 'SessionController');
    }
  }

  Future<void> clearSession() async {
    session.value = null;
    await SharedPrefServices.clearSessionId();
    developer.log('Session cleared', name: 'SessionController');
  }
}



