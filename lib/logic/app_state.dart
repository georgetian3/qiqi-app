import 'package:qiqi/api/lib/api.dart';
import 'package:qiqi/logic/auth.dart';
import 'package:qiqi/logic/location.dart';
import 'package:qiqi/logic/navigation.dart';


class AppState {
  late final ApiClient apiClient;
  late final NavigationState navigationState;
  late final LocationState locationState;
  late final AuthState authState;

  AppState({
    apiClient,
    navigationState,
    authState,
    userState,
    locationState,
  }) {
    this.apiClient = apiClient ?? ApiClient(
      basePath: 'http://qiqi.georgetian.com:8000/',
      authentication: HttpBearerAuth(),
    );
    this.navigationState = navigationState ?? NavigationState();
    this.authState = authState ?? AuthState(this.apiClient);
    this.locationState = locationState ?? LocationState();
  }
  copy({NavigationState? navigationState, ApiClient? apiClient, AuthState? authState}) {
    return AppState(
      navigationState: navigationState ?? this.navigationState,
      apiClient: apiClient ?? this.apiClient,
      authState: authState ?? this.authState
    );
  }
}

