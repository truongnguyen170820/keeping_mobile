
import 'package:shared_preferences/shared_preferences.dart';

import 'local_store.dart';

class SharedPreferencesLocalStore extends LocalStore {
  static const PREF_ACCESS_TOKEN = 'PREF_ACCESS_TOKEN';
  static const SAVE_OR_NOT_CREDENTIALS = 'SAVE_OR_NOT_CREDENTIALS';

  @override
  Future<bool> hasAuthenticated() async {
    String accessToken = await getAccessToken();
    return accessToken.isNotEmpty ;
  }

  @override
  Future setAccessToken(String sessionId) async {
    (await SharedPreferences.getInstance())
        .setString(PREF_ACCESS_TOKEN, sessionId);
  }

  @override
  Future<String> getAccessToken() async {
    return (await SharedPreferences.getInstance())
            .getString(PREF_ACCESS_TOKEN) ??
        '';
  }

  @override
  Future removeCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.wait([
      prefs.remove(PREF_ACCESS_TOKEN),
      prefs.remove(SAVE_OR_NOT_CREDENTIALS),
    ]);
  }

  @override
  Future<bool> getSaveOrNotCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(SAVE_OR_NOT_CREDENTIALS) == 'true'
        ? true
        : false;
  }

  @override
  Future setSaveOrNotCredentials(bool status) async {
    (await SharedPreferences.getInstance())
        .setString(SAVE_OR_NOT_CREDENTIALS, status.toString());
  }
}
