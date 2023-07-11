
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loginlagi/pages/camera.dart';
import 'package:loginlagi/pages/profile.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List Screens = [
    Camera(),
    Profile(),
  ];
  int _selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        index:  _selectedIndex,
        color: Color.fromARGB(255, 61, 25, 1),
        backgroundColor: Color.fromARGB(0, 255, 0, 0),
        buttonBackgroundColor: Colors.redAccent,
        items: const [
          Icon(
            Icons.camera,
            size: 30,
            color: Colors.white
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white
          ),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Screens[_selectedIndex],
    );
  }
}