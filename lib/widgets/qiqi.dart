import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qiqi/widgets/login.dart';
import 'package:qiqi/widgets/map.dart';
import '../logic/app_state.dart';
import 'find_my_bike.dart';
import 'package:redux/redux.dart';
import 'settings.dart';

class Page {
  final Widget page;
  final IconData icon;
  final String name;
  const Page(this.page, this.icon, this.name);
}

const navigationPages = [
  Page(MapPage(), Icons.search, 'map'),
  Page(FindMyBikePage(), Icons.search, 'findMyBike'),
  Page(SettingsPage(), Icons.settings, 'settings'),
];

class QiQi extends StatelessWidget {
  final Store<AppState> store;
  const QiQi(this.store, {super.key});
  @override build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'QiQi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
