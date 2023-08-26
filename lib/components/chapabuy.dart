import 'dart:math';
import 'package:flutter/material.dart';
import 'package:chapasdk/chapasdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChapaWalletFillerScreen extends StatefulWidget {
  @override
  _ChapaWalletFillerScreenState createState() => _ChapaWalletFillerScreenState();
}

class _ChapaWalletFillerScreenState extends State<ChapaWalletFillerScreen> {
  final TextEditingController _amountController = TextEditingController();
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            ElevatedButton(
              onPressed: () async {
                // Get the current user's email and names from Firebase
                final user = FirebaseAuth.instance.currentUser;
                String email = user!.email!;
                String firstName = user.displayName!.split(' ')[0];
                String lastName = user.displayName!.split(' ')[1];

                // Generate a random txRef
                String txRef = _random.nextInt(1000000).toString();

                // Use the Chapa Flutter SDK to create a new transaction
                Chapa.paymentParameters(
                  context: context,
                  publicKey: 'CHAPUBK_TEST-1sUD1G7MVyRPG8I1mrZSCUFiLvRk1LJd',
                  currency: 'ETB',
                  amount: _amountController.text,
                  email: email,
                  phone: '911223344',
                  firstName: firstName,
                  lastName: lastName,
                  txRef: txRef,
                  title: 'title',
                  desc:'desc',
                  namedRouteFallBack: '/second', // fall back route name
                );

                // Store the transaction details in a new collection in Firebase
                await FirebaseFirestore.instance.collection('transactions').add({
                  'txRef': txRef,
                  'uid': user.uid,
                  'firstName': firstName,
                  'lastName': lastName,
                  'amount': _amountController.text,
                });
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
