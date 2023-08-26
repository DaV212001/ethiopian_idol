import 'package:ethiopian_idol/screens/compete.dart';
import 'package:flutter/material.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/screens/submission.dart';


class DetailsEntryScreen extends StatefulWidget {
  final String category;

  const DetailsEntryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _DetailsEntryScreenState createState() => _DetailsEntryScreenState();
}

class _DetailsEntryScreenState extends State<DetailsEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

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
        title: Text('Enter Your Details',  style: TextStyle(
            color:
            themeProvider.selectedTheme == 'dark' ?Color(0xFFFFFD00):Colors.grey.shade800,
            fontFamily:
            'Poppins',
            fontWeight:
            FontWeight.w700,
            fontSize:
            20),),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubmissionScreen(category: widget.category),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
