import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final BMFMapController mapController;
  late final BMFMapWidget map;
  final BMFCircle circle = BMFCircle(
      center: BMFCoordinate(39.917215, 116.380341),
      radius: 10,
      width: 0,
      strokeColor: Colors.transparent,
      fillColor: Color.fromARGB(128, 255, 0, 0),
      lineDashType: BMFLineDashType.LineDashTypeSquare);

  @override
  void initState() {
    super.initState();
    map = BMFMapWidget(
      onBMFMapCreated: (controller) async {
        mapController = controller;
        mapController.showUserLocation(true);
        print('mapController#########################################');
        print(mapController);
        print(controller);
      },
      mapOptions: BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.380341),
        zoomLevel: 12,
        trafficEnabled: true,
        compassEnabled: true,
        showMapPoi: true,
        buildingsEnabled: true,
        baseIndoorMapEnabled: true,
        showIndoorMapPoi: true,
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [map],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        print('onpressed');
        bool result = await mapController.addCircle(circle);
        print(result);
      }),
    );
  }
}
