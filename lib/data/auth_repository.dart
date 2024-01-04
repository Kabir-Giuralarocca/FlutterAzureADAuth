import 'package:flutter_azure_ad_auth/domain/oauth_config.dart';
import 'package:logger/logger.dart';

class AuthRepository {
  static var log = Logger();

  Future<void> azureLogin() async {
    try {
      final result = await OauthConfig.aadOAuth.login();
      result.fold(
        (failure) => throw Exception(failure.message),
        (token) => log.i(
          'Logged in successfully, your access token: ${token.accessToken}',
        ),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  Future<void> azureLogout() async {
    await OauthConfig.aadOAuth.logout();
  }
}
