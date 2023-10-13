import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  build(BuildContext context) {
    
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.380341),
        zoomLevel: 12,
        mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
    return Container(
      constraints: const BoxConstraints.expand(),
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          print('onBMFMapCreated');
        },
        mapOptions: mapOptions,
      ),
    );
  }
}
