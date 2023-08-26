import 'package:ethiopian_idol/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';


class SubmissionScreen extends StatelessWidget {
  final String category;

  const SubmissionScreen({Key? key, required this.category}) : super(key: key);

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.media);
    if (result != null) {
      // Handle the selected file
    }
  }

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
        title: Text('Submit Your Audition',  style: TextStyle(
            color:
            themeProvider.selectedTheme == 'dark' ?Color(0xFFFFFD00):Colors.grey.shade800,
            fontFamily:
            'Poppins',
            fontWeight:
            FontWeight.w700,
            fontSize:
            20),),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _pickFile,
          child: Text('Select a Video or Audio File'),
        ),
      ),
    );
  }
}