import 'package:flutter/material.dart';
import 'package:flutter_azure_ad_auth/access_screen.dart';
import 'package:flutter_azure_ad_auth/oauth_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Azure AD Authentication',
      theme: ThemeData.dark(useMaterial3: true),
      navigatorKey: OauthConfig.navigatorKey,
      home: const AccessScreen(),
    );
  }
}
