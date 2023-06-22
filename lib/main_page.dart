import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_2/rank_page.dart';
import 'package:flutter_application_kobis_2/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _idx = 1;
  dynamic loadPage = Text('검색하세요');
  @override
  Widget build(BuildContext context) {
    var menus = [
      RankPage(),
      RankPage(),
      SearchPage(),
    ];
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)));
    items.add(
        BottomNavigationBarItem(label: 'BoxOffice', icon: Icon(Icons.stars)));
    items.add(BottomNavigationBarItem(
        label: 'MovieSearch', icon: Icon(Icons.search)));
    return Scaffold(
      body: loadPage,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _idx,
        onTap: (value) {
          setState(() {
            _idx = value;
            loadPage = menus[value];
          });
        },
      ),
    );
  }
}
