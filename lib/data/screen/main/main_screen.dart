import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/screen/home/home_screen.dart';
import 'package:restaurant_app/data/screen/search/search_screen.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNav,
        onTap: (value) {
          context.read<IndexNavProvider>().setIndexBottomNav = value;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            tooltip: 'Search',
          ),
        ],
      ),
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNav) {
            0 => HomeScreen(),
            _ => SearchScreen(),
          };
        },
      ),
    );
  }
}
