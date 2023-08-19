import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/homepage.dart';
import 'screens/voting.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'screens/profilescreen.dart';
import 'package:flutter/material.dart' show Hero;
import 'package:ethiopian_idol/networking/youtube_fetcher.dart';
import 'package:provider/provider.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyScreen(
          pages: [
            MyHomePage(),
            Voting(),
            ProfileScreen()
          ],
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: Center(
            child: Hero(tag: 'logo', child: Image.asset('images/usesplash.png'),)
        ),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVideos();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeProvider>(context);
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
      bottomNavigationBar: ValueListenableBuilder<String?>(
        valueListenable: themeManager.selectedThemeNotifier,
        builder: (context, selectedTheme, child) {
          return CurvedNavigationBar(
            iconPadding: 7,
            height: 60,
            index: _currentIndex,
            color: Colors.blue,
            backgroundColor:
            _currentIndex == 0 ? selectedTheme == 'dark' ? Colors.black: Colors.white : _currentIndex == 1 ? selectedTheme == 'dark' ? Colors.black:Colors.white : selectedTheme == 'dark' ? Colors.blue.shade700 : Colors.blue.shade100,
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
          );
        },
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  final ValueNotifier<String?> _selectedThemeNotifier = ValueNotifier(null);

  ValueNotifier<String?> get selectedThemeNotifier => _selectedThemeNotifier;

  String? get selectedTheme => _selectedThemeNotifier.value;

  void setSelectedTheme(String? value) {
    if (_selectedThemeNotifier.value != value) {
      _selectedThemeNotifier.value = value;
      notifyListeners();
    }
  }
}
