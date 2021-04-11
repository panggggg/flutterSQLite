import 'package:flutter/material.dart';
import 'package:flutter_sqlite/screens/insertscreen.dart';
import 'package:flutter_sqlite/screens/displayscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List pages = [InsertScreen(), DisplayScreen()];

  @override
  Widget build(BuildContext context) {
    Widget bottomNavbar = BottomNavigationBar(
        currentIndex: currentIndex,
    onTap: (int index){
          setState(() {
            currentIndex = index;
          });
    },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), title: Text("เพิ่มสมาชิก")),
        BottomNavigationBarItem(
            icon: Icon(Icons.group), title: Text("รายชื่อสมาชิก")),
      ],
    );
    return Scaffold(
      body: pages[currentIndex],

    );
  }
}
