import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Layout extends StatelessWidget {
  const Layout({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ログイン'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        currentIndex: navigationShell.currentIndex,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
