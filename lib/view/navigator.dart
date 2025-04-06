import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_app/view/bag/bag_screen.dart';
import 'package:sneakers_app/view/home/home_screen.dart';
import 'package:sneakers_app/view/profile/profile_screen.dart';
import 'package:sneakers_app/view/wishlist/wishlist_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    MyBagScreen(),
    WishlistScreen(),
    Profile(),
  ];

  final List<Widget> _navigationItems = [
    Icon(CupertinoIcons.home),
    Icon(CupertinoIcons.shopping_cart),
    Icon(CupertinoIcons.heart),
    Icon(CupertinoIcons.person),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: _navigationItems,
        onTap: _onItemTapped,
        index: _selectedIndex,
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.black,
        height: 55,
        animationCurve: Curves.easeInOut,
      ),
    );
  }
}
