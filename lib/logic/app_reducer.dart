import 'package:qiqi/logic/auth.dart';
import 'package:qiqi/logic/navigation.dart';

import 'app_state.dart';

AppState appStateReducer(AppState state, action) => AppState(
  navigationState: navigationReducer(state.navigationState, action),
  authState: authReducer(state.authState, action),
);
