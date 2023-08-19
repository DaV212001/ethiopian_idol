import 'package:ethiopian_idol/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final items = [
      {'text': 'Change profile', 'icon': Icons.person},
      {'text': 'Change pin', 'icon': Icons.vpn_key},
      {'text': 'Change theme', 'icon': Icons.color_lens_outlined},
      {'text': 'Change language', 'icon': Icons.language},
      {'text': 'Invite friends', 'icon': Icons.person_add},
      {'text': 'FAQ', 'icon': Icons.help_outline},
      {'text': 'Feedback', 'icon': Icons.feedback},
      {'text': 'Contact Us', 'icon': Icons.contact_support},
      {'text': 'About', 'icon': Icons.info_outline},
      {'text': 'Share', 'icon': Icons.share}
    ];
    final themeItems = [
      DropdownMenuItem(
          child: Text('Dark',
            style: TextStyle(
                color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w200
            ),
          ), value: 'dark'),
      DropdownMenuItem(
          child: Text('Light',
            style: TextStyle(color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black,
            fontFamily: 'Poppins',
              fontWeight: FontWeight.w200
            ),
          ), value: 'light'),
    ];
    return Scaffold(
      backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF202932) : Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
        title: Center(child: Text('Profile')),
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF202932) : Colors.blue,
      ),
      body: Column(
        children: [
          Card(
            elevation: 20,
            color: themeProvider.selectedTheme == 'dark' ? Color(0xFF466895) : Colors.blue.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.person, size: 40, color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name',
                            style:
                            TextStyle(color:
                            themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.grey.shade800, fontFamily:
                            'Outfit-black', fontWeight:
                            FontWeight.w600, fontSize:
                            15)),
                        Container(
                          decoration: BoxDecoration(
                            color: themeProvider.selectedTheme == 'dark' ? Color(0xFF2FA9DA) :Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding:
                          EdgeInsets.symmetric(vertical: 4),
                          child: Text('Audience', style:
                          TextStyle(color:
                          themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.grey.shade800, fontFamily:
                          'Outfit-black', fontWeight:
                          FontWeight.w400, fontSize:
                          15)),
                        ),
                        Text('Phone Number',
                            style:
                            TextStyle(color:
                            themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.grey.shade800, fontFamily:
                            'Outfit-black', fontWeight:
                            FontWeight.w600, fontSize:
                            15)),
                      ],
                    ),
                  ]),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black,),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeProvider.selectedTheme == 'dark' ? Color(0xFF466895) : Colors.blue.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  if (items[index]['text'] == "Change theme") {
                    return ListTile(
                      leading:
                      Icon(items[index]['icon'] as IconData, color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black,),
                      title:
                      Text(items[index]['text'] as String, style: TextStyle(color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black),),
                      trailing: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        dropdownColor: themeProvider.selectedTheme=='dark'?Color(0xFF19212E):Colors.white,
                        value : themeProvider.selectedTheme,
                        onChanged:(value){
                          themeProvider.setSelectedTheme(value);
                        },
                        items : themeItems,
                      ),
                    );
                  } else {
                    return ListTile(
                      leading:
                      Icon(items[index]['icon'] as IconData, color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black,),
                      title:
                      Text(items[index]['text'] as String, style: TextStyle(color: themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.black),),
                    );
                  }
                },
                separatorBuilder: (context, index) => Divider(
                  indent: 72,
                  color : themeProvider.selectedTheme == 'dark' ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
