import 'package:flutter/material.dart';
import 'package:flutter_sqlite/screens/homescreen.dart';
import 'package:flutter_sqlite/utils/database_helper.dart';
import 'package:flutter_sqlite/screens/insertscreen.dart';
import 'package:flutter_sqlite/screens/displayscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  databaseHelper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
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
      bottomNavigationBar: bottomNavbar,

    );
  }
}

