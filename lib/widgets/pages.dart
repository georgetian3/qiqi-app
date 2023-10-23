import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qiqi/logic/navigation.dart';
import 'package:qiqi/widgets/map.dart';
import '../logic/app_state.dart';
import 'find_my_bike.dart';
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

class Pages extends StatelessWidget {
  const Pages({super.key});
  @override build(BuildContext context) {
    return MaterialApp(
      title: 'QiQi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StoreConnector<AppState, int>(
        converter: (store) => store.state.navigationState.index,
        builder: (context, index) => Scaffold(
          appBar: AppBar(title: const Text('title')),
          bottomNavigationBar: StoreConnector<AppState, Function>(
            converter: (store) => (index) => store.dispatch(IndexAction(index)),
            builder: (context, onDestinationSelected) => NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (destination) => onDestinationSelected(destination),
              destinations: [
                for (final page in navigationPages) NavigationDestination(icon: Icon(page.icon), label: page.name)
              ]
            ),
          ),
          body: IndexedStack(
            index: index,
            children: [for (final page in navigationPages) page.page],
          ),
        ),
      ),
    );
  }
}
