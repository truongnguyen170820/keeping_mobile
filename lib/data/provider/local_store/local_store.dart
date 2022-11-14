abstract class LocalStore {
  Future<bool> hasAuthenticated();

  Future setAccessToken(String accessToken);

  Future<String> getAccessToken();

  Future removeCredentials();

  Future<bool> getSaveOrNotCredentials();

  Future setSaveOrNotCredentials(bool status);

}
