import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OauthConfig {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static String get redirectUri {
    if (kIsWeb) {
      return "https://flutteraad.azurewebsites.net";
    } else {
      return "https://login.live.com/oauth20_desktop.srf";
    }
  }

  static final Config config = Config(
    tenant: "552bed02-4512-450c-858d-84cfe2b4186d",
    clientId: "7e6bec33-522b-43d9-8301-b3d6db18f773",
    scope: "User.Read",
    navigatorKey: navigatorKey,
    redirectUri: redirectUri,
    webUseRedirect: false,
  );

  static final AadOAuth aadOAuth = AadOAuth(config);
}
