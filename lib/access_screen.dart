import 'package:flutter/material.dart';
import 'package:flutter_azure_ad_auth/auth_repository.dart';
import 'package:flutter_azure_ad_auth/oauth_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccessScreen extends StatefulWidget {
  const AccessScreen({super.key});

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  bool hasCachedInfo = false;
  String token = "";

  @override
  void initState() {
    super.initState();
    OauthConfig.aadOAuth.hasCachedAccountInformation.then((value) {
      setState(() {
        hasCachedInfo = value;
      });
    });
    OauthConfig.aadOAuth.getAccessToken().then((value) {
      setState(() {
        token = value ?? "";
      });
    });
  }

  void _login() {
    AuthRepository.azureLogin().then((value) {
      setState(() {
        token = value ?? "";
        hasCachedInfo = true;
      });
    });
  }

  void _logout() {
    AuthRepository.azureLogout().then((value) {
      setState(() {
        token = "";
        hasCachedInfo = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Azure AD Authentication",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            Visibility(
              visible: hasCachedInfo && token.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      "Token:",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      token,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _login(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                foregroundColor: Colors.black,
              ),
              icon: SvgPicture.asset("assets/microsoft.svg"),
              label: const Text("Login Azure AD"),
            ),
            const SizedBox(height: 8),
            Visibility(
              visible: hasCachedInfo && token.isNotEmpty,
              child: OutlinedButton(
                onPressed: () => _logout(),
                child: const Text("Remove Token"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
