import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/voting.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'screens/profilescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(
        pages: [
          MyHomePage(),
          Voting(),
          ProfileScreen()
        ],
      ),
    );
  }
}

class MyScreen extends StatefulWidget {
  final List<Widget> pages;

  MyScreen({required this.pages});

  @override
  _MyScreenState createState() => _MyScreenState();
}
class _MyScreenState extends State<MyScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: widget.pages
            .asMap()
            .map((index, page) => MapEntry(
          index,
          Visibility(
            visible: index == _currentIndex,
            child: page,
          ),
        ))
            .values
            .toList(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: Colors.blue,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 200),
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.how_to_vote),
            label: 'Vote',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
