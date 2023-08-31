import 'dart:async';
import 'package:ethiopian_idol/screens/loginandregistration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/homepage.dart';
import 'screens/voting.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'screens/profilescreen.dart';
import 'package:ethiopian_idol/networking/youtube_fetcher.dart';
import 'package:provider/provider.dart';
import 'components/categorymodel.dart';
import 'screens/compete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Chapa.configure(privateKey: "CHASECK_TEST-QlVxOwMIyNJCuIipknSMvWfTWJ0pm2K4");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // Add the ChangeNotifierProvider for CategoryModel
        ChangeNotifierProvider(create: (context) => CategoryModel()),
      ],
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
  final PageController _controller = PageController(initialPage: 0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_controller.page == 2) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyScreen(
              pages: [
                MyHomePage(),
                Voting(),
                CategorySelectionScreen(),
                ProfileScreen()
              ],
            ),
          ),
        );
      } else {
        _controller.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF28345A),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF8CD31),
            ),
          ),
          PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              Image.asset('images/splash1.jpg', fit: BoxFit.contain,),
              Image.asset('images/splash2.jpg', fit: BoxFit.contain,),
              Image.asset('images/splash3.jpg', fit: BoxFit.contain,),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MyScreen(
                      pages:
                      [
                        MyHomePage(),
                        Voting(),
                        CategorySelectionScreen(),
                        ProfileScreen()
                      ],
                    ),
                  ));
                },
                child:
                Text('Skip'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Define a global GlobalKey variable
final GlobalKey<MyScreenState> myScreenKey =
GlobalKey<MyScreenState>();

class MyScreen extends StatefulWidget {
  final List<Widget> pages;

  MyScreen({required this.pages});

  @override
  MyScreenState createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  int get profileScreenIndex =>
      3;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body:
      Stack(children:
      widget.pages.asMap().map((index, page) =>
          MapEntry(index, Visibility(visible:
          index == currentIndex, child:
          page))).values.toList()),
      bottomNavigationBar: ValueListenableBuilder<String?>(
        valueListenable: themeManager.selectedThemeNotifier,
        builder: (context, selectedTheme, child) {
          return CurvedNavigationBar(
            iconPadding: 7,
            height: 65,
            index: currentIndex,
            color: selectedTheme == 'dark'
                ? Colors.black
                : Color(0xFFF8CD31),
            backgroundColor: currentIndex == 0
                ? selectedTheme == 'dark'
                ? Color(0xFF121212)
                : Colors.white
                : currentIndex == 1
                ? selectedTheme == 'dark'
                ? Color(0xFF121212)
                : Colors.white
                : selectedTheme == 'dark'
                ? Color(0xFF121212)
                : Colors.white,
            animationDuration: Duration(milliseconds: 200),
            items: [
              CurvedNavigationBarItem(
                  child: Icon(
                    Icons.home,
                    color:
                    selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black,
                  ),
                  label: 'Home',
                  labelStyle: TextStyle(
                      color:
                      selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200)),
              CurvedNavigationBarItem(
                  child: Icon(Icons.thumbs_up_down,
                      color:
                      selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black),
                  label: 'Vote',
                  labelStyle: TextStyle(
                      color:
                      selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200)),
              CurvedNavigationBarItem(
                  child: Icon(Icons.emoji_events,
                      color:
                      selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black),
                  label: 'Compete',
                  labelStyle: TextStyle(
                      color:
                      selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200)),
              CurvedNavigationBarItem(
                  child: Icon(Icons.person,
                      color:
                      selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black),
                  label: 'Profile',
                  labelStyle: TextStyle(
                      color:
                      selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200)),
            ],
            onTap:
                (index) {
              setState(() {
                currentIndex = index;
              });
              // Check if the index corresponds to the profile button
              if (index == 3) {
                // Get the current user from Firebase
                User? user = FirebaseAuth.instance.currentUser;
                // Check if the user is logged in
                if (user == null) {
                  // If the user is not logged in, navigate to the login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                          LoginScreen(),
                    ),
                  );
                } else {
                  // If the user is logged in, navigate to the profile screen
                  setState(() {
                    currentIndex = profileScreenIndex;
                  });
                }
              }
            },
          );
        },
      ),
    );
  }
}




class ThemeProvider extends ChangeNotifier {
  String _selectedTheme = 'light';
  final ValueNotifier<String?> selectedThemeNotifier = ValueNotifier(null);

  ThemeProvider() {
    // Load the selected theme from SharedPreferences when the ThemeProvider is created
    _loadSelectedTheme();
  }

  String get selectedTheme => _selectedTheme;

  void setSelectedTheme(String value) {
    _selectedTheme = value;
    notifyListeners();
    selectedThemeNotifier.value = value;

    // Save the selected theme to SharedPreferences when it is changed
    _saveSelectedTheme();
  }

  Future<void> _loadSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('selectedTheme') ?? 'light';
    setSelectedTheme(theme);
  }

  Future<void> _saveSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedTheme', _selectedTheme);
  }
}