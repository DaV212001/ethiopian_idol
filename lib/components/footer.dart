import 'package:flutter/material.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:url_launcher/url_launcher.dart';


class FooterCustom extends StatelessWidget {
  const FooterCustom({
    super.key,
    required this.themeProvider,
  });

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              String url = 'https://mssethiopia.com/';
              // Check if the URL can be launched
              if (await canLaunch(url)) {
// Launch the URL
                await launch(url);
              } else {
// Show an error message
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch $url')));
              }
            },
            child: Text(
              'Powered by Micro Sun and Solutions PLC',
              style: TextStyle(
                color: themeProvider.selectedTheme == 'dark' ? Colors.yellow : Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w200,
                fontSize: 15,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.phone),
              GestureDetector(
                onTap: () {
                  launch('tel:6494');
                },
                child: Text(': 6494'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
