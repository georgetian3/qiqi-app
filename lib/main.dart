import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:qiqi/logic/app_reducer.dart';
import 'package:qiqi/logic/app_state.dart';
import 'package:qiqi/widgets/qiqi.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BMFMapSDK.setAgreePrivacy(true);
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType('ENTER AK HERE', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
    await BMFAndroidVersion.initAndroidVersion();
  }
  Store<AppState> store = Store<AppState>(appStateReducer, initialState: AppState());
  runApp(QiQi(store));
}
