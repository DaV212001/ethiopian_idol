import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiopian_idol/components/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


import 'dart:io';
import 'package:file_picker/file_picker.dart';

class DetailsEntryScreen extends StatefulWidget {
  final String category;

  const DetailsEntryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _DetailsEntryScreenState createState() => _DetailsEntryScreenState();
}

class _DetailsEntryScreenState extends State<DetailsEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String firstName = 'Name';
  String status = 'Audience';
  String phoneNumber = '';
  double walletBalance = 0;
  File? auditionFile;
  bool agreedToTerms = false; // add a bool field to manage the state of the checkbox
  String fileName = ''; // add a string field to store the name of the selected file
  bool isAudioFile = false; // add a bool field to check if the selected file is an audio file
  bool isVideoFile = false; // add a bool field to check if the selected file is a video file

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

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4', 'wav', 'mov'], // specify the allowed file extensions
    );

    if(result != null) {
      setState(() {
        auditionFile = File(result.files.single.path!);
        fileName = result.files.single.name; // store the name of the selected file
        isAudioFile = result.files.single.extension == 'mp3' || result.files.single.extension == 'wav'; // check if the selected file is an audio file
        isVideoFile = result.files.single.extension == 'mp4' || result.files.single.extension == 'mov'; // check if the selected file is a video file
      });
    } else {
      // User canceled the picker
    }
  }
  bool issubmitting = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    const kTextFeildStyle = InputDecoration(
      contentPadding:
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
    return Scaffold(
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.white,
    appBar: AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.yellow,
    statusBarIconBrightness:themeProvider.selectedTheme == 'dark' ?Brightness.light: Brightness.dark),
    backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Colors.yellow,
    title: Text('Enter Your Details', style: TextStyle(
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
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Flexible(
    flex: 2,
    child:
    Container(
    margin: EdgeInsets.only(bottom: 20),
    height:
    200.0,
    child:
    Image.asset('images/logouse.png'),
    ),
    ),
    TextFormField(
    style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),
    controller: _firstNameController,
    decoration: kTextFeildStyle.copyWith(labelText: 'First Name', labelStyle: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your first name';
    }
    return null;
    },
    ),
    SizedBox(height: 16.0),
    TextFormField(
    style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),
    controller: _lastNameController,
    decoration: kTextFeildStyle.copyWith(labelText: 'Last Name', labelStyle: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your last name';
    }
    return null;
    },
    ),
    SizedBox(height: 16.0),
    TextFormField(
    style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),
    controller:_phoneNumberController,
    decoration: kTextFeildStyle.copyWith(labelText: 'Phone Number', labelStyle: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
    }else if(!value.contains(RegExp(r'^[0-9]{10}$'))){ // use a regular expression to check if the phone number is valid
    return 'Please enter a valid phone number';
    }
    return null;
    },
    ),
    SizedBox(height: 16.0),
    TextFormField(
    style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black),
    controller: _emailController,
    decoration: kTextFeildStyle.copyWith(labelText: 'Email', labelStyle: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your email';
    }else if(!value.contains(RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'))){ // use a regular expression to check if the email is valid
    return 'Please enter a valid email';
    }
    return null;
    },
    ),
    SizedBox(height :16.0),
    Flexible(
    child :Row(
    mainAxisAlignment :MainAxisAlignment.spaceBetween,
    children:[
    Flexible(
    child :RoundedButton(
    onpressed:_pickFile,
    title :'Pick Audition File',
    color :Colors.blue,
    ),
    ),
    SizedBox(width :10),
    Flexible(
    child :auditionFile !=null?Container(
    padding :EdgeInsets.all(8),
    decoration :BoxDecoration(
    color :themeProvider.selectedTheme=='dark'?Color(0xFF121212): Colors.yellow,
    borderRadius :BorderRadius.circular(5),
    ),
    child :Row(
    mainAxisAlignment :MainAxisAlignment.spaceBetween,
    children:[
    Flexible(
    flex :1,
    child :isAudioFile?Icon(Icons.audiotrack, color :themeProvider.selectedTheme=='dark'?Color(0xFFFFFD00): Colors.grey.shade800):isVideoFile?Icon(Icons.videocam, color :themeProvider.selectedTheme=='dark'?Color(0xFFFFFD00): Colors.grey.shade800):Icon(Icons.error, color :themeProvider.selectedTheme=='dark'?Color(0xFFFFFD00): Colors.grey.shade800),
    ),
    SizedBox(width :5),
    Flexible(
    flex :3,
    child :Text(fileName, style :TextStyle(color :themeProvider.selectedTheme=='dark'?Color(0xFFFFFD00): Colors.grey.shade800)),
    ),
    Flexible(
    flex :1,
    child :IconButton(iconSize :20, icon :Icon(Icons.close), onPressed :(){
    setState((){
    auditionFile =null;
    fileName ='';
    isAudioFile =false;
    isVideoFile =false;
    });
    }),
    ),
    ],
    ),
    ):Container(),
    ),
    ],
    ),
    ),
    SizedBox(height :16.0),
    // add a CheckboxListTile widget and a TextButton widget to display the agree to terms and conditions checkbox and the read terms text
      CheckboxListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        value: agreedToTerms,
        onChanged: (value) {
          setState(() {
            agreedToTerms = value!;
          });
        },
        title: Text('I agree to the terms and conditions',
            style: TextStyle(color: Colors.black)),
        controlAffinity: ListTileControlAffinity.leading, // add this line
      ),

      TextButton(
        onPressed :(){
          // navigate to the TermsScreen that describes the terms for data collection
          Navigator.push(context, MaterialPageRoute(builder :(context)=>TermsScreen()));
        },
        child :Text('Terms and Conditions', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.blue:Colors.blue)),
      ),
      SizedBox(height: 10,),
      if(issubmitting)SpinKitThreeInOut(color: Colors.yellow, size: 30),
      Flexible(
        child: RoundedButton(
          onpressed :() async{
            if(_formKey.currentState!.validate()){
              if(agreedToTerms){
                setState(() {
                  issubmitting = true;
                });
                if(auditionFile !=null){
                  if(walletBalance >=50){
                    walletBalance -=50;
                    await FirebaseFirestore.instance.collection('transactions').add({
                      'uid': FirebaseAuth.instance.currentUser!.uid,
                      'amount': '-50',
                      'timestamp': DateTime.now(),
                    });
                    setState(() {
                      issubmitting = false;
                    });
                    showDialog(
                      context :context,
                      builder :(BuildContext context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title :Text("Audition Submitted!"),
                          content :Text("Your audition has been submitted.50 birr taken from your wallet."),
                          actions:[
                            TextButton(
                              child :Text("OK"),
                              onPressed :(){
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }else{
                    setState(() {
                      issubmitting = false;
                    });
                    showDialog(
                      context :context,
                      builder :(BuildContext context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title :Text("Insufficient Funds!"),
                          content :Text("Insufficient funds please refill your wallet."),
                          actions:[
                            TextButton(
                              child :Text("OK"),
                              onPressed :(){
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }else{
                  setState(() {
                    issubmitting = false;
                  });
                  showDialog(
                    context :context,
                    builder :(BuildContext context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        title :Text("No File Selected!"),
                        content :Text("Please select an audition file."),
                        actions:[
                          TextButton(
                            child :Text("OK"),
                            onPressed :(){
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }else{
                setState(() {
                  issubmitting = false;
                });
                showDialog(
                  context :context,
                  builder :(BuildContext context){
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title :Text("Terms Not Agreed!"),
                      content :Text("Please agree to the terms and conditions."),
                      actions:[
                        TextButton(
                          child :Text("OK"),
                          onPressed :(){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
          color: agreedToTerms? Colors.blue: Colors.blueGrey,
          title: 'Submit',
        ),
      ),
    ],
    ),
    ),
    ),
    );
  }
}


class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.yellow,
            statusBarIconBrightness:themeProvider.selectedTheme == 'dark' ?Brightness.light: Brightness.dark),
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Colors.yellow,
        title: Text('Terms and Conditions', style: TextStyle(
            color:
            themeProvider.selectedTheme == 'dark' ?Color(0xFFFFFD00):Colors.grey.shade800,
            fontFamily:
            'Poppins',
            fontWeight:
            FontWeight.w700,
            fontSize:
            20),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Introduction', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black, fontWeight :FontWeight.bold)),
              SizedBox(height :8.0),
              Text('These terms and conditions govern your use of our app; by using our app, you accept these terms and conditions in full. If you disagree with these terms and conditions or any part of these terms and conditions, you must not use our app.', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
              SizedBox(height :16.0),
              Text('Data Collection', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black, fontWeight :FontWeight.bold)),
              SizedBox(height :8.0),
              Text('We collect information from you when you register on our app, submit an audition, or fill out a form. When registering on our app, as appropriate, you may be asked to enter your name, email address, phone number or other details to help you with your experience.\n\nWe also collect information about your use of our app, such as the pages you visit and the actions you take within the app. This information is used to improve our app and provide a better user experience.', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
              SizedBox(height :16.0),
              Text('Use of Data', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black, fontWeight :FontWeight.bold)),
              SizedBox(height :8.0),
              Text('Any of the information we collect from you may be used in one of the following ways:\n\n- To personalize your experience\n- To improve our app\n- To improve customer service\n- To process transactions\n- To send periodic emails\n\nYour information, whether public or private, will not be sold, exchanged, transferred, or given to any other company for any reason whatsoever, without your consent, other than for the express purpose of delivering the purchased product or service requested.\n\nWe may also use your information to contact you about updates to our app or to provide you with information about products or services that may be of interest to you.', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
              SizedBox(height :16.0),
              Text('Data Protection', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black, fontWeight :FontWeight.bold)),
              SizedBox(height :8.0),
              Text('We implement a variety of security measures to maintain the safety of your personal information when you enter, submit, or access your personal information.\n\nWe offer the use of a secure server. All supplied sensitive/credit information is transmitted via Secure Socket Layer (SSL) technology and then encrypted into our payment gateway providers database only to be accessible by those authorized with special access rights to such systems and are required to keep the information confidential.\n\nAfter a transaction, your private information (credit cards, social security numbers, financials, etc.) will not be stored on our servers.', style :TextStyle(color :themeProvider.selectedTheme=='dark'?Colors.white:Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
