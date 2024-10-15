import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housy_app/views/home.dart';
import 'package:housy_app/views/inbox.dart';
import 'package:housy_app/views/profile.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    InboxPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.0,
                spreadRadius: 2.0,
                offset: Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black, // Cambia a tu color preferido
            unselectedItemColor: Colors.grey,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
            type: BottomNavigationBarType
                .fixed, // Cambia a "shifting" si prefieres
          ),
        ),
      ),
    );
  }
}
