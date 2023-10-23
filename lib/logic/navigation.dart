
import 'package:redux/redux.dart';

class NavigationState {
  int index;
  NavigationState({this.index = 0});
}

class IndexAction {
  final int index;
  IndexAction(this.index);
}

NavigationState indexReducer(NavigationState state, IndexAction action) {
  return NavigationState(index: action.index);
}

Reducer<NavigationState> navigationReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, IndexAction>(indexReducer)
]);