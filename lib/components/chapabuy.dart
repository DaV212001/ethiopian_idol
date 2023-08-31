import 'dart:math';
import 'package:flutter/material.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/main.dart';

class ChapaWalletFillerScreen extends StatefulWidget {
  @override
  _ChapaWalletFillerScreenState createState() => _ChapaWalletFillerScreenState();
}

class _ChapaWalletFillerScreenState extends State<ChapaWalletFillerScreen> {
  final TextEditingController _amountController = TextEditingController();
  final _random = Random();
  bool ispaying = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.yellow,
        title: Text('Buy Currency'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            if(ispaying) SpinKitThreeInOut(color: Colors.yellow),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  ispaying = true;
                });
                try { // Get the current user's uid from Firebase
                  final user = FirebaseAuth.instance.currentUser;
                  String uid = user!.uid;

                  // Retrieve the user's firstName from Firestore
                  DocumentSnapshot snapshot = await FirebaseFirestore.instance
                      .collection('users').doc(uid).get();
                  String firstName = snapshot['firstName'];
                  String lastName = snapshot['lastName'];


                // Generate a random txRef

                String txRef = TxRefRandomGenerator.generate(prefix: 'etIDOL');
                // Access the generated transaction reference
                String storedTxRef = TxRefRandomGenerator.gettxRef;
                // Use the Chapa Flutter SDK to create a new transaction


                try {
                  await Chapa.getInstance.startPayment(
                    context: context,
                    onInAppPaymentSuccess: (successMsg) async {
                      await FirebaseFirestore.instance.collection('transactions').add({
                        'txRef': storedTxRef,
                        'uid': uid,
                        'firstName': firstName,
                        'lastName': lastName,
                        'amount': _amountController.text,
                        'timestamp': FieldValue.serverTimestamp()
                      });
                      print('PAYMENT SUCCESS!');// Handle success events
                      setState(() {
                        ispaying = false;
                      });
                      // Show the pop-up card
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            title: Text("Wallet Fill Successful!"),
                            content: Text("Your wallet has been successfully filled."),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onInAppPaymentError: (errorMsg) {
                      setState(() {
                        ispaying = false;
                      });
                      print('PAYMENT FAILURE');// Handle error
                    },
                    amount: _amountController.text,
                    currency: 'ETB',
                    txRef: storedTxRef,
                    firstName: 'firstName',
                    lastName: 'lastName',
                    phoneNumber: '0912345678',
                  ); // start Payment Code
                } on ChapaException catch (e) {
                  setState(() {
                    ispaying = false;
                  });
                  if (e is AuthException) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Problem with Authentication')),
                    );// Handle authentication error
                  } else if (e is InitializationException) {
                    // Handle initialization error
                  } else if (e is NetworkException) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Network error, please check your internet connection')),
                    );// Handle network error
                  } else if (e is ServerException) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Experiencing problems with server')),
                    ); // Handle server-side error
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Unkown Error. Please try again')),
                    );// Handle unknown error
                  }
                }
                // Store the transaction details in a new collection in Firebase
                }on FirebaseAuthException catch (e) {
                  setState(() {
                    ispaying = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message!)),
                  );
                }

              },


              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
