import 'package:flutter/material.dart';
import 'package:hello_world/ui/home_view_page.dart';
import 'package:hello_world/ui/profile_view_page.dart';

class Home extends StatefulWidget{
  
  const Home({super.key});

  @override
  State<Home> createState() => _Home();

}

class _Home extends State<Home>{
  int currentIndex = 0;

  final pages = [
    HomeViewPage(),
    ProfileViewPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        currentIndex: currentIndex,
        onTap: (index) => {
          setState(() => currentIndex = index)
        },
      ),
      body: pages[currentIndex],
    );
  }

}