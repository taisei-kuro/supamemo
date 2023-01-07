import 'package:flutter/material.dart';
import 'package:supamemo/pages/add_post_page.dart';
import 'package:supamemo/pages/home_page.dart';
import 'package:supamemo/pages/my_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  static const _screens = [
    HomePage(),
    AddPostPage(),
    MyPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: '投稿'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
