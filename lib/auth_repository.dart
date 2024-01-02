import 'package:flutter_azure_ad_auth/oauth_config.dart';
import 'package:logger/logger.dart';

class AuthRepository {
  static var log = Logger();

  static Future<String?> azureLogin() async {
    try {
      final result = await OauthConfig.aadOAuth.login();
      result.fold(
        (failure) => log.e(failure),
        (token) => log.i(
          'Logged in successfully, your access token: ${token.accessToken}',
        ),
      );
      final token = await OauthConfig.aadOAuth.getAccessToken();
      return token;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  static Future<void> azureLogout() async {
    await OauthConfig.aadOAuth.logout();
  }
}
