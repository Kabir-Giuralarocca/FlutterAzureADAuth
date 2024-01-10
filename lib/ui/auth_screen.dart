import 'package:flutter/material.dart';
import 'package:flutter_azure_ad_auth/data/auth_repository.dart';
import 'package:flutter_azure_ad_auth/ui/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Azure AD Authentication",
            ),
          ),
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Initial) {
                BlocProvider.of<AuthBloc>(context).add(OnInitial());
                return const SizedBox();
              } else if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                String token = state is Authenticated ? state.token : "";
                String error = state is Error ? state.error : "";
                return AuthLayout(state: state, token: token, error: error);
              }
            },
          ),
        ),
      ),
    );
  }
}

class AuthLayout extends StatefulWidget {
  const AuthLayout({
    super.key,
    required this.state,
    required this.token,
    required this.error,
  });

  final AuthState state;
  final String token;
  final String error;

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    AuthBloc bloc = BlocProvider.of<AuthBloc>(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.state is Authenticated,
              child: Column(
                children: [
                  Text(
                    "Token:",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    widget.token,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => bloc.add(OnLogin()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                foregroundColor: Colors.black,
              ),
              icon: SvgPicture.asset("assets/microsoft.svg"),
              label: const Text("Login Azure AD"),
            ),
            const SizedBox(height: 8),
            Visibility(
              visible: widget.state is Authenticated,
              child: OutlinedButton(
                onPressed: () => bloc.add(OnLogout()),
                child: const Text("Remove Token"),
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: widget.state is Error,
              child: Text(
                widget.error,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
