import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:ethiopian_idol/screens/loginandregistration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/components/chapabuy.dart';
import 'dart:math'as math;

// Define a global GlobalKey variable
final GlobalKey<_ProfileScreenState> _profileScreenKey = GlobalKey<_ProfileScreenState>();

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final VoidCallback navigateToProfileScreen;

  String firstName = 'Name';
  String status = 'Audience';
  String phoneNumber = '';
  double walletBalance = 0;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _getWalletBalance();
  }

  Future<void> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) { // check if there is a user currently logged in
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        firstName = userData['firstName'];
        status = userData['status'];
        if(status=='Contestant'){phoneNumber = userData['phoneNumber'];}
      });
    }
  }

  Future<void> _getWalletBalance() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) { // check if there is a user currently logged in
      // Query the transactions collection to get the total amount of money bought by the user
      final transactions = await FirebaseFirestore.instance.collection('transactions')
          .where('uid', isEqualTo: user.uid)
          .get();
      double totalAmount = 0;
      for (final transaction in transactions.docs) {
        totalAmount += double.parse(transaction['amount']);
      }
      setState(() {
        walletBalance = totalAmount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero, () => _getUserData());

    final MyScreenState? myScreenState = myScreenKey.currentState;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser; // get the current user
    final items = [
      {
        'text': 'Change profile'  ,
        'icon':  Icons.person
      },
      // change the text and icon of the first item based on whether there is a user currently logged in
      {'text': 'Change password', 'icon': Icons.vpn_key},
      {'text': 'Fill Wallet', 'icon': Icons.wallet},
      {'text': 'Change language', 'icon': Icons.language},
      {'text': 'Invite friends', 'icon': Icons.person_add},
      {'text': 'FAQ', 'icon': Icons.help_outline},
      {'text': 'Feedback', 'icon': Icons.feedback},
      {'text': 'Contact Us', 'icon': Icons.contact_support},
      {'text': 'About', 'icon': Icons.info_outline},
      {'text': 'Share', 'icon': Icons.share}
    ];


    return Scaffold(
      backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Color(0xFFF3F4F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: themeProvider.selectedTheme=='dark'? Brightness.light: Brightness.dark),
        title: Center(child: Text('Profile', style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w700),)),
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Color(0xFFF3F4F6),
      ),
      body: Column(
        children: [
          Card(
            elevation: 20,
            color: themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.white,
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
                        Text(firstName, // display the first name of the logged-in user
                            style:
                            TextStyle(color:
                            themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.grey.shade800, fontFamily:
                            'Poppins', fontWeight:
                            FontWeight.w700, fontSize:
                            15)),
                        Container(
                          decoration: BoxDecoration(
                            color: themeProvider.selectedTheme == 'dark' ? Color(0xFFFFFD00) : Color(0xFFFFFD00),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding:
                          EdgeInsets.symmetric(vertical: 4),
                          child: Text(status, // display the status of the logged-in user
                              style:
                              TextStyle(color:
                              themeProvider.selectedTheme == 'dark' ? Colors.black :Colors.grey.shade800, fontFamily:
                              'Outfit-black', fontWeight:
                              FontWeight.w400, fontSize:
                              15)),
                        ),
                        status == "Contestant" ? Text(phoneNumber, // display the phone number of the logged-in user if their status is "contestant"
                            style:
                            TextStyle(color:
                            themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.grey.shade800, fontFamily:
                            'Poppins', fontWeight:
                            FontWeight.w700, fontSize:
                            15)) : Container(),
                      ],
                    ),
                  ]),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, color: themeProvider.selectedTheme == 'dark' ? Colors.white : Colors.black,),
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
              decoration:
              BoxDecoration(
                color: themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10, top: 50),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Text('Powered by Micro Sun Technologies', style:
                          TextStyle(color:
                          themeProvider.selectedTheme == 'dark' ?Colors.yellow:Colors.black, fontFamily:
                          'Poppins', fontWeight:
                          FontWeight.w200, fontSize:
                          15)),
                          ElevatedButton(onPressed: (){
                            FirebaseAuth.instance.signOut();
                            setState(() {
                              firstName='Name';
                              status='Unknown';
                              phoneNumber='unknown';
                            });
                          },
                              child: Text('Log out'))
                        ],
                      ),
                    );
                  } else {
                    if (items[index]['text'] == "Change theme") {
                      return ListTile(
                        leading: Container(
                          decoration:
                          BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFFD00)),
                          height: 30,
                          width: 30,
                          child: Icon(
                            items[index]['icon'] as IconData,
                            color:
                            themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
                          ),
                        ),
                        title: Text(
                          items[index]['text'] as String,
                          style: TextStyle(
                              color:
                              themeProvider.selectedTheme == 'dark' ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w200),
                        ),
                        trailing:
                        // Replace the DropdownButton with an IconButton
                        MyIconButton(),
                      );
                    } else if (items[index]['text'] == "Fill Wallet") { // add a onTap function to navigate to the ChangeProfileScreen
                      return Column(
                          children:[
                            ListTile(
                              leading: Container(
                                decoration:
                                BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFFD00)),
                                height: 30,
                                width: 30,
                                child: Icon(
                                  items[index]['icon'] as IconData,
                                  color:
                                  themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
                                ),
                              ),
                              title:
                              Text(
                                items[index]['text'] as String,
                                style: TextStyle(
                                    color:
                                    themeProvider.selectedTheme == 'dark' ? Colors.white : Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w200),
                              ),
                              onTap: () {
                                // navigate to the chapa wallet filler screen.
                                Navigator.push(context, MaterialPageRoute(builder:(context)=>ChapaWalletFillerScreen())).then((value) => _getWalletBalance());
                              },
                            ),
                            Container(child :Text('Wallet Balance : $walletBalance ETB'))
                          ]
                      );
                    } else {
                      return ListTile(
                        leading: Container(
                          decoration:
                          BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFFD00)),
                          height: 30,
                          width: 30,
                          child: Icon(
                            items[index]['icon'] as IconData,
                            color:
                            themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
          ),
        ),
        title:
        Text(
          items[index]['text'] as String,
          style: TextStyle(
              color:
              themeProvider.selectedTheme == 'dark' ? Colors.white : Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200),
        ),
      );
    }
    }
    },
      separatorBuilder: (context, index) => index == items.length - 1
          ? Container()
          : Divider(
        indent: 72,
        color:
        themeProvider.selectedTheme == 'dark' ? Colors.white : Colors.grey,
      ),
    ),
      ),
      ),
        ],
      ),
    );
  }
}





class MyIconButton extends StatefulWidget {
  @override
  _MyIconButtonState createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  @override
  Widget build(BuildContext context) {
    // Get the current ThemeProvider from the context
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      icon: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * math.pi,
            child: Icon(themeProvider.selectedTheme == 'dark' ? Icons.nightlight_round : Icons.wb_sunny, color: themeProvider.selectedTheme == 'dark' ?Colors.white:Colors.black, size: 30,),
          );
        },
      ),
      onPressed: () {
        // Toggle the theme mode when the button is pressed
        themeProvider.setSelectedTheme(themeProvider.selectedTheme == 'dark' ? 'light' : 'dark');
        themeProvider.selectedTheme == 'dark' ? _controller.forward() : _controller.reverse();
      },
    );
  }
}

