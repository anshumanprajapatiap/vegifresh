import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:vegifresh/screen/categoriesScreen.dart';
import 'package:vegifresh/screen/homeScreen.dart';
import 'package:vegifresh/screen/profileScreen.dart';

import '../provider/cartProvider.dart';
import '../widget/textWidget.dart';
import 'cartScreen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page':HomeScreen(title: 'Home'), 'title':'Home'},
    {'page':CategoriesScreen(), 'title':'Category'},
    {'page':CartScreen(), 'title':'Cart'},
    {'page':ProfileScreen(), 'title':'Profile'}
  ];
  void _selectedPage(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList = cartProvider.getCartItems.values.toList();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   title: Text(_pages[_selectedIndex]['title']),
      //   elevation:2,
      // ),
      body: _pages[_selectedIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        currentIndex: _selectedIndex,
        onTap: _selectedPage,
        selectedItemColor: Theme.of(context).cardColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: MediaQuery.of(context).size.width*0.07,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon( _selectedIndex==0 ? Icons.home_filled: Icons.home_outlined),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon( _selectedIndex==1 ? Icons.category_sharp: Icons.category_outlined),
              label: 'Catergory'
          ),
          BottomNavigationBarItem(
              icon: badge.Badge(
                  badgeAnimation: const badge.BadgeAnimation.slide(),
                  badgeStyle: badge.BadgeStyle(
                    shape: badge.BadgeShape.circle,
                    badgeColor: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  position: badge.BadgePosition.topEnd(top: -7, end: -7),
                  badgeContent: FittedBox(
                      child: TextWidget(
                          text: cartItemsList.length.toString(),
                          color: Colors.white,
                          textSize: 15)),
                  child: Icon( _selectedIndex==2 ? Icons.shopping_cart: Icons.shopping_cart_outlined)
              ),
              label: 'Cart'
          ),
          BottomNavigationBarItem(
              icon: Icon( _selectedIndex==3 ? Icons.account_circle: Icons.account_circle_outlined),
              label: 'Profile'
          )
        ],
      ),
    );
  }
}
