import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiopian_idol/components/categorymodel.dart';
import 'package:ethiopian_idol/screens/loginandregistration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:ethiopian_idol/screens/voting.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowCard extends StatefulWidget {
  ShowCard({
    required this.height,
    required this.width,
    this.onpressed,
    required this.link,
    required this.isVotecard,
    required this.category,
    required this.name,
    required this.votes,
    this.description, required this.video
  });

  final double height;
  final double width;
  final String link;
  final bool isVotecard;
  final String category;
  final String name;
  final int votes;
  final String? description;
  final void Function()? onpressed;
  final String video;

  @override
  _ShowCardState createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Use the Provider.of method to access the CategoryModel instance
    final categoryModel = Provider.of<CategoryModel>(context);
    // Get the value of the selected category
    final category = categoryModel.selectedCategory;
    return GestureDetector(
        onTap: widget.onpressed,
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: widget.isVotecard == false
                ? Container(
              height: widget.height,
              width: widget.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(widget.link, fit: BoxFit.fill),
              ),
            )
                : Column(
                children: [
            Card(
            color:
            themeProvider.selectedTheme == 'dark' ? Color(0xFFFFFD00) : Color(0xFFF3F4F6),
        shadowColor: themeProvider.selectedTheme=='dark'?Color(0xFFFFFD00): Colors.black,
        elevation: 10,
        margin: EdgeInsets.zero,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
          Container(
          height: widget.height,
          width: widget.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:
            Image.network(widget.link, fit: BoxFit.fill),
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(widget.name, style:
        TextStyle(color:
        themeProvider.selectedTheme == 'dark'
            ? Colors.black
            : Colors.black, fontFamily:
        'Outfit-black', fontWeight:
        FontWeight.w600, fontSize:
        15)),
        Text('${widget.votes} votes', style:
        TextStyle(color:
        themeProvider.selectedTheme == 'dark'
            ? Colors.black
            : Colors.black, fontFamily:
        'Outfit-black', fontWeight:
        FontWeight.w400, fontSize:
        15)),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          themeProvider.selectedTheme == 'dark'
                              ? Colors.black
                              : Colors.grey.shade300),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade100)
                  ),
                  onPressed: () {
                    // Use the then method of the Navigator.push function to execute a callback function that refreshes the data on the voting screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContestantvotingDetailsPage(name: widget.name, description: widget.description, imageUrl: widget.link, video: widget.video))).then((_) {
                      // Call refreshData to refresh the data on the voting screen
                      Voting.of(context)?.refreshData();
                    });
                  },
                  child: Text('View', style: TextStyle(color: themeProvider.selectedTheme=='dark'? Colors.white: Colors.black ), textAlign: TextAlign.center,)
              )

            ],
    ),

    ],
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }
}




class ContestantvotingDetailsPage extends StatefulWidget {
  final String name;
  final String? description;
  final String imageUrl;
  final String video;

  ContestantvotingDetailsPage({
    required this.name,
    required this.description,
    required this.imageUrl, required this.video,
  });

  @override
  _ContestantvotingDetailsPageState createState() => _ContestantvotingDetailsPageState();
}

class _ContestantvotingDetailsPageState extends State<ContestantvotingDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isupdatingBalance = false;
  double walletBalance = 0;
  TextEditingController _voteCountController = TextEditingController(text: '1');
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700000),
    );

    _animationController.repeat(reverse: true);

    _getWalletBalance();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video??'',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

  Future<void> _voteForContestant(String contestantName, int voteCount) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (walletBalance >= voteCount * 2) {
        setState(() {
          isupdatingBalance = true;
        });
        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        String firstName = snapshot['firstName'];
        String lastName = snapshot['lastName'];
        // Deduct voteCount * 2 from wallet balance
        await FirebaseFirestore.instance.collection('transactions').add({
          'txRef': 'vote',
          'uid': user.uid,
          'firstName': firstName,
          'lastName': lastName,
          'amount': '-${voteCount * 2}',
          'timestamp': FieldValue.serverTimestamp()
        });

        // Record the votes in Firebase
        final voteDoc = await FirebaseFirestore.instance.collection('votes').doc(contestantName).get();
        if (voteDoc.exists) {
          // Increment the vote count by voteCount
          await FirebaseFirestore.instance.collection('votes').doc(contestantName).update({
            'voteCount': FieldValue.increment(voteCount),
          });
        } else {
          // Create a new document with voteCount
          await FirebaseFirestore.instance.collection('votes').doc(contestantName).set({
            'voteCount': voteCount,
          });
        }

        // Show success dialog
        await _getWalletBalance();
        setState(() {
          isupdatingBalance = false;
        });


        final updatedWalletBalance = walletBalance;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text("Vote Recorded!"),
              content: Text(
                  "You've voted for $contestantName successfully.\nWallet balance is now $updatedWalletBalance."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Show insufficient funds dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text("Insufficient Funds!"),
              content: Text("Insufficient funds in your wallet."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.description!,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            if (isupdatingBalance)
              SpinKitThreeInOut(color: Colors.yellow),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + 0.1 * _animationController.value,
                  child: child,
                );
              },
              child: ElevatedButton.icon(
                onPressed: () async {
                  print(walletBalance);

                  final user = FirebaseAuth.instance.currentUser;
                  print(user?.uid);
                  if (user == null) {
                    // Navigate to LoginScreen if user is not logged in
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );

                  } else {
                    // Show a card that lets the user enter the number of votes they want to put in
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int voteCount = 1;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              title: Text("Enter Number of Votes"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _voteCountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Number of Votes',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        voteCount = int.tryParse(value) ?? 1;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Text('Price of Vote: ${voteCount * 2}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text("Vote"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _voteForContestant(widget.name, voteCount);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }
                },
                icon: Icon(Icons.thumb_up),
                label: Text(
                  'Vote',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
