import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiopian_idol/components/footer.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:ethiopian_idol/screens/loginandregistration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/components/chapabuy.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

// Define a global GlobalKey variable
final GlobalKey<_ProfileScreenState> _profileScreenKey = GlobalKey<_ProfileScreenState>();

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final VoidCallback navigateToProfileScreen;

  String firstName = 'loading...';
  String status = 'loading...';
  String phoneNumber = 'loading...';
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
        phoneNumber = userData['phoneNumber'];
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
      {'text': 'Change theme' , 'icon' : Icons.palette},
      {'text': 'Fill Wallet', 'icon': Icons.wallet},
      {'text': 'Change language', 'icon': Icons.language},
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
        SystemUiOverlayStyle(statusBarColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.yellow, statusBarIconBrightness: themeProvider.selectedTheme=='dark'? Brightness.light: Brightness.dark),
        title: Center(child: Text('Profile', style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w700),)),
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Colors.yellow,
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
                     Text(phoneNumber, // display the phone number of the logged-in user if their status is "contestant"
                        style:
                        TextStyle(color:
                        themeProvider.selectedTheme == 'dark' ? Colors.white :Colors.grey.shade800, fontFamily:
                        'Poppins', fontWeight:
                        FontWeight.w700, fontSize:
                        15)) ,
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
    return Padding(
      padding: EdgeInsets.only(top: 36),
        child: FooterCustom(themeProvider: themeProvider));
    } else {
    if (items[index]['text'] == "Change theme") {
    return ListTile(
    leading: Icon(
    items[index]['icon'] as IconData,
    size: 30,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
    leading: Icon(
    items[index]['icon'] as IconData,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
    Container(child :Text('Wallet Balance : $walletBalance ETB', style: TextStyle(color: themeProvider.selectedTheme == 'dark' ? Colors.white : Colors.black),))
    ]
    );
    }else if (items[index]['text'] == "Change profile") {
    return ListTile(
    leading: Icon(
    items[index]['icon'] as IconData,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
    // Navigate to the RegisterScreen
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    },
    );
    } else if (items[index]['text'] == "Change password") {
    return ListTile(
    leading: Icon(
    items[index]['icon'] as IconData,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
    // Show an alert dialog
    showDialog(
    context: context,
    builder: (context) {
    // Create a text editing controller
    final passwordController = TextEditingController();

    return AlertDialog(
    title: Text('Change password'),
    content: TextField(
    controller: passwordController,
    decoration:
    InputDecoration(hintText: 'Enter your new password'),
    obscureText: true,
    ),
    actions: [
    TextButton(
    child: Text('Change'),
    onPressed: () async {
    // Get the new password from the controller
    final newPassword = passwordController.text;

    // Update the user's password in Firebase
    try {
    await user!.updatePassword(newPassword);
    // Close the dialog
    Navigator.pop(context);
    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
    Text('Your password has been changed successfully')));
    } on FirebaseAuthException catch (e) {
    // Close the dialog
    Navigator.pop(context);
    // Show an error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
    Text(e.message!)));
    }
    },
    ),
    ],
    );
    },
    );
    },
    );
    } else if (items[index]['text'] == "FAQ") {
    return ListTile(
    leading: Icon(
    items[index]['icon'] as IconData,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
    // Navigate to the FAQScreen
    Navigator.push(context, MaterialPageRoute(builder:(context)=>FAQScreen()));
    },
    );
    } else if (items[index]['text'] == "Feedback") {
    return ListTile(
    leading: Icon(
    items[index]['icon'] as IconData,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
    // Show an alert dialog
    showDialog(
    context: context,
    builder: (context) {
    // Create a text editing controller
    final feedbackController = TextEditingController();

    return AlertDialog(
    title: Text('Feedback'),
    content: TextField(
    controller: feedbackController,
    decoration: InputDecoration(hintText: 'Write your feedback here'),
    ),
    actions: [
    TextButton(
    child: Text('Submit'),
    onPressed: () {
    // Get the feedback text from the controller
    final feedbackText = feedbackController.text;

    // Do something with the feedback text, such as sending it to a server or saving it locally

    // Close the dialog
    Navigator.pop(context);

    // Show a message that says "Your feedback is appreciated, thank you"
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
backgroundColor: Colors.yellow,
        content:
        Text('Your feedback is appreciated, thank you!',
          style:
          TextStyle(
            color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w200)
        ),
    ),
    );
    },
    ),
    ],
    );
    },
    );
    },
    );
    } else if (items[index]['text'] == "Contact Us") {
    return ListTile(
    leading: Icon(
    items[index]['icon'] as IconData,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
    onTap: () async {
// Define the URL of the website
    const url = 'https://mssethiopia.com/';

// Check if the URL can be launched
    if (await canLaunch(url)) {
// Launch the URL
    await launch(url);
    } else {
// Show an error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
    },
    );
    } else if (items[index]['text'] == "Share") {
    return ListTile(
    leading: Icon(
    items[index]['icon'] as IconData,
    color:
    themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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
      // Define the content you want to share, such as the apk file path or a link to download the app
      final content = '...';

      // Share the content with other apps
      Share.share(content);
      },
      );
      } else {
      return ListTile(
      leading: Icon(
      items[index]['icon'] as IconData,
      color:
      themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
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


class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.selectedTheme=='dark'? Color(0xFF121212):Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.selectedTheme=='dark'?Color(0xFF121212):Colors.yellow,
        systemOverlayStyle: SystemUiOverlayStyle(systemNavigationBarContrastEnforced: true,
        statusBarColor: themeProvider.selectedTheme=='dark'?Color(0xFF121212):Colors.yellow,),
        title: Text('FAQ'),
      ),
      body: Center(
        child: Text('Details of Ethiopian Idol', style: TextStyle(color:themeProvider.selectedTheme=='dark'? Colors.white:Colors.black, ),),
      ),
    );
  }
}
