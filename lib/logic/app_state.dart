import 'dart:io';

import 'package:qiqi/api/lib/api.dart';

class AuthState {
  final ApiClient apiClient;
  late final AuthApi authApi;
  String? token;
  DateTime expiresAt = DateTime.now();

  AuthState(this.apiClient) {
    authApi = AuthApi(apiClient);
  }
}

class RefreshTokenAction {
  final String username;
  final String password;
  final bool force;
  RefreshTokenAction(this.username, this.password, {this.force = false});
}

AuthState refreshTokenReducer(AuthState state, RefreshTokenAction action) {
  AuthState newState = AuthState(state.apiClient);

  if (action.force || state.token == null ||
    state.expiresAt.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch < 10 * 1000 // expires within 10 seconds
  ) {
    try {
      state.authApi.tokenTokenPost(action.username, action.password)
        .then((token) {
          if (token == null) {
            newState.token = null;
            return;
          }
          newState.token = token.accessToken;
          newState.expiresAt = DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch + token.expiresIn * 1000
          );
        });
    } on ApiException catch (e) {
      if (e.code == HttpStatus.unauthorized) {
        print('Invalid username/password');
      } else {
        print('Auth apiException???');
        print(e);
      }
      newState.token = null;
    }
  }
  if (newState != null) {
    newState.apiClient.addDefaultHeader('Authorization', 'Bearer ${newState.token}');
  }
  return newState;
}

class AppState {
  int navigationPageIndex;
  late final ApiClient apiClient;
  late final UserApi userApi;
  late final LocationApi locationApi;
  late final AuthState authState;

  AppState({
    this.navigationPageIndex = 0,
    apiClient,
    authState,
    userState,
    locationState,
  }) {
    this.apiClient = apiClient ?? ApiClient(
      basePath: 'http://qiqi.georgetian.com:8000/',
      authentication: HttpBearerAuth(),
    );
    this.authState = authState ?? AuthState(apiClient);
    userApi = UserApi(apiClient);
    locationApi = LocationApi(apiClient);
  }
}
