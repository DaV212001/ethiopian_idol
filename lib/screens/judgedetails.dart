import 'package:flutter/material.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';

class Judge {
  final String name;
  final String imageUrl;
  final String bio;

  Judge({
    required this.name,
    required this.imageUrl,
    required this.bio,
  });
}

class JudgeDetailsPage extends StatelessWidget {
  final Judge judge;

  const JudgeDetailsPage({
    Key? key,
    required this.judge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.selectedTheme=='dark'? Color(0xFF121212):Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.selectedTheme=='dark'? Color(0xFF121212):Colors.yellow,
        title: Text(judge.name),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(judge.imageUrl),
              Text(
                'About',
                style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 25),
              ),
              SizedBox(height: 8.0),
              Text(
                judge.bio,
                style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w200, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
