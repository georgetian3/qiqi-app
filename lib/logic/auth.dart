import 'dart:io';

import 'package:qiqi/api/lib/api.dart';
import 'package:redux/redux.dart';

class AuthState {
  final ApiClient apiClient;
  late final AuthApi authApi;
  String? token;
  DateTime expiresAt = DateTime.now();
  String? username;
  String? password;
  bool save = false;

  AuthState(this.apiClient) {
    authApi = AuthApi(apiClient);
  }
  AuthState copyWith({
    ApiClient? apiClient,
    AuthApi? authApi,
    String? token,
    DateTime? expiresAt,
    String? username,
    String? password,
    bool? save,
  }) {
    AuthState newState = AuthState(apiClient ?? this.apiClient);
    newState.token = token ?? this.token;
    newState.expiresAt = expiresAt ?? this.expiresAt;
    newState.username = username ?? this.username;
    newState.password = password ?? this.password;
    newState.save = save ?? this.save;
    return newState;
  }
}


class ToggleSaveAction {}

AuthState toggleSaveReducer(AuthState state, ToggleSaveAction action) {
  return state.copyWith(save: !state.save);
}

class RefreshTokenAction {
  final String? username;
  final String? password;
  final bool force;
  RefreshTokenAction(this.username, this.password, {this.force = false});
}

AuthState refreshTokenReducer(AuthState state, RefreshTokenAction action) {
  AuthState newState = AuthState(state.apiClient);
  if (action.force || state.token == null ||
    state.expiresAt.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch < 10 * 1000 // expires within 10 seconds
  ) {
    newState.username = action.username ?? state.username;
    newState.password = action.password ?? state.password;
    try {
      state.authApi.tokenTokenPost(newState.username ?? '', newState.password ?? '').then((token) {
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
  newState.token ?? newState.apiClient.addDefaultHeader('Authorization', 'Bearer ${newState.token}');
  return newState;
}

Reducer<AuthState> authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, ToggleSaveAction>(toggleSaveReducer),
  TypedReducer<AuthState, RefreshTokenAction>(refreshTokenReducer),
]);