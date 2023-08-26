import 'package:ethiopian_idol/screens/compete.dart';
import 'package:ethiopian_idol/screens/homepage.dart';
import 'package:ethiopian_idol/screens/profilescreen.dart';
import 'package:ethiopian_idol/screens/voting.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiopian_idol/components/roundedbutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.onLogin});
  final VoidCallback onLogin;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    const kTextFeildStyle = InputDecoration(
      hintText: 'Enter your password',
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

    return WillPopScope(
      onWillPop: () async {
        // Reset the index of the bottom navigation bar to 0
        myScreenKey.currentState?.setState(() {
          myScreenKey.currentState?.currentIndex = 0;
        });
        // Navigate back to MyScreen when the back button is pressed
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
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Center(
              child: Text('Login',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700))),
          backgroundColor: Color(0xFFF3F4F6),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key:_formKey,
              child:
              Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children:<Widget>[
                  Flexible(
                    child:
                    Container(
                      height:
                      200.0,
                      child:
                      Image.asset('images/logouse.png'),
                    ),
                  ),
                  SizedBox(
                    height:
                    48.0,
                  ),
                  TextFormField(
                    textAlign:
                    TextAlign.center,
                    keyboardType:
                    TextInputType.emailAddress,
                    controller:_emailController,
                    decoration:kTextFeildStyle.copyWith(hintText:'Enter your email'),
                    validator:(value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height:
                    8.0,
                  ),
                  TextFormField(
                    obscureText:true,
                    textAlign:
                    TextAlign.center,
                    controller:_passwordController,
                    decoration:kTextFeildStyle.copyWith(hintText:'Enter your password'),
                    validator:(value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height:
                    24.0,
                  ),
                  RoundedButton(onpressed:
                      () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          showSpinner=true;
                        });
                        await FirebaseAuth.instance.signInWithEmailAndPassword(email:_emailController.text,password:_passwordController.text,);
                        await Navigator.of(context).maybePop();


                        setState(() {
                          showSpinner=false;
                        });
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                        Text(e.message!)),
                        );
                      }
                    }
                  }, color:
                  Colors.lightBlueAccent, title:
                  'Log In'),
                  // Add a row widget to display the text and the link for registration
                  Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children:<Widget>[
                        // Add a text widget to display "Don't have an account?"
                        Text("Don't have an account?",
                            style:
                            TextStyle(color:
                            Colors.grey.shade800)),
                        // Add a gesture detector widget to handle the tap event on the link
                        GestureDetector(
                          onTap:
                              () {
                            // Navigate to the RegisterScreen
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>RegisterScreen(onLogin: widget.onLogin),),);
                          },
                          // Add a text widget to display "Register" as a link
                          child:
                          Text("Register",
                              style:
                              TextStyle(color:
                              Colors.blueAccent, decoration:
                              TextDecoration.underline)),
                        )
                      ]
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  RegisterScreen({required this.onLogin});
  final VoidCallback onLogin;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool showSpinner = false;
  bool isContestant = false;

  @override
  Widget build(BuildContext context) {
    const kTextFeildStyle = InputDecoration(
      hintText: 'Enter your password',
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        // Reset the index of the bottom navigation bar to 0
        myScreenKey.currentState?.setState(() {
          myScreenKey.currentState?.currentIndex = 0;
        });
        // Navigate back to MyScreen when the back button is pressed
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
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Center(
              child: Text('Register',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700))),
          backgroundColor: Color(0xFFF3F4F6),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child:
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal:
            24.0),
            child:
            Form(
              key:_formKey,
              child:
              Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children:<Widget>[
                  Flexible(
                    child:
                    Container(
                      height:
                      200.0,
                      child:
                      Image.asset('images/logouse.png'),
                    ),
                  ),
                  SizedBox(
                    height:
                    37.0,
                  ),
                  Center(
                    child: ToggleButtons(
                      borderColor:
                      Colors.yellow,
                      fillColor:
                      Colors.yellow,
                      borderWidth:
                      2,
                      selectedBorderColor:
                      Colors.black,
                      selectedColor:
                      Colors.black,
                      borderRadius:
                      BorderRadius.circular(30),
                      children:<Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child:
                          Text('Audience',
                            style:
                            TextStyle(fontSize:
                            16, fontFamily: 'Poppins', fontWeight: FontWeight.w700),),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child:
                          Text('Contestant',
                              style:
                              TextStyle(fontSize:
                              16, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                        ),
                      ],
                      onPressed:(int index){
                        setState(() {
                          isContestant =
                              index ==1;
                        });
                      },
                      isSelected:[
                        !isContestant,isContestant
                      ],
                    ),
                  ),
                  SizedBox(height:
                  8),
                  TextFormField(
                    textAlign:
                    TextAlign.center,
                    keyboardType:
                    TextInputType.emailAddress,
                    controller:_emailController,
                    decoration:kTextFeildStyle.copyWith(hintText:'Enter your email'),
                    validator:(value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:
                  8),
                  TextFormField(
                    textAlign:
                    TextAlign.center,
                    controller:_firstNameController,
                    decoration:kTextFeildStyle.copyWith(hintText:'Enter your first name'),
                    validator:(value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:
                  8),
                  TextFormField(
                    textAlign:
                    TextAlign.center,
                    controller:_lastNameController,
                    decoration:kTextFeildStyle.copyWith(hintText:'Enter your last name'),
                    validator:(value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:
                  8),
                  if(isContestant)
                    TextFormField(
                      textAlign:
                      TextAlign.center,
                      keyboardType:
                      TextInputType.phone,
                      controller:_phoneNumberController,
                      decoration:kTextFeildStyle.copyWith(hintText:'Enter your phone number'),
                      validator:(value){
                        if(value==null||value.isEmpty){
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                  SizedBox(height:
                  8),
                  TextFormField(
                    obscureText:true,
                    textAlign:
                    TextAlign.center,
                    controller:_passwordController,
                    decoration:kTextFeildStyle.copyWith(hintText:'Enter your password'),
                    validator:(value){
                      if(value==null||value.isEmpty){
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:
                  24),
                  RoundedButton(
                    onpressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            showSpinner = true;
                          });
                          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                            'firstName': _firstNameController.text,
                            'lastName': _lastNameController.text,
                            'status': isContestant ? 'Contestant' : 'Audience',
                            if (isContestant) 'phoneNumber': _phoneNumberController.text,
                          });

                          // Call onWillPop manually
                          await Navigator.of(context).maybePop();

                          setState(() {
                            showSpinner = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message!)),
                          );
                        }
                      }
                    },
                    color: Colors.lightBlueAccent,
                    title: 'Register',
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



