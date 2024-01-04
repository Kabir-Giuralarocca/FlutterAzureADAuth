import 'package:equatable/equatable.dart';
import 'package:flutter_azure_ad_auth/data/auth_repository.dart';
import 'package:flutter_azure_ad_auth/domain/oauth_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Initial()) {
    on<OnInitial>((event, emit) async {
      emit(Loading());
      try {
        bool hasCachedInfo =
            await OauthConfig.aadOAuth.hasCachedAccountInformation;
        String token = await OauthConfig.aadOAuth.getAccessToken() ?? "";
        emit(
          hasCachedInfo && token.isNotEmpty
              ? Authenticated(token)
              : UnAuthenticated(),
        );
      } catch (e) {
        emit(UnAuthenticated());
        emit(Error(e.toString()));
      }
    });

    on<OnLogin>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.azureLogin();
        String token = await OauthConfig.aadOAuth.getAccessToken() ?? "";
        emit(Authenticated(token));
      } catch (e) {
        emit(UnAuthenticated());
        emit(Error(e.toString()));
      }
    });

    on<OnLogout>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.azureLogout();
        emit(UnAuthenticated());
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }
}
