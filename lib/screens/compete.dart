import 'package:ethiopian_idol/main.dart';
import 'package:ethiopian_idol/screens/compete.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/screens/inputdetail.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List<String> categories = [
    'Singing',

    'Dancing',

    'Comedy',

    'Magic',

    'Acting',

    'Poetry reading',

    'Instruments',


    'Impersonation',
    'Juggling',
    'Acrobatics',
    'Painting or drawing',


 'Fashion show'

  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:themeProvider.selectedTheme == 'dark' ?Brightness.light: Brightness.dark),
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Colors.transparent,
        title: Text('Select a Category', style: TextStyle(
        color:
        themeProvider.selectedTheme == 'dark' ?Color(0xFFFFFD00):Colors.grey.shade800,
          fontFamily:
          'Poppins',
          fontWeight:
          FontWeight.w700,
          fontSize:
          20),),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(categories[index], style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsEntryScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}










