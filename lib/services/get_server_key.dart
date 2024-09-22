import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  GetServerKey._();
  static Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database'
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({}),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
