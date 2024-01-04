import 'package:flutter/material.dart';
import 'package:flutter_azure_ad_auth/domain/oauth_config.dart';
import 'package:flutter_azure_ad_auth/ui/auth_screen.dart';

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
      home: const AuthScreen(),
    );
  }
}
