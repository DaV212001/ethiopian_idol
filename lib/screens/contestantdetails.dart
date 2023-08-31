import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiopian_idol/screens/loginandregistration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContestantDetailsPage extends StatefulWidget {
  final PlaylistItem video;

  const ContestantDetailsPage({Key? key, required this.video}) : super(key: key);

  @override
  _ContestantDetailsPageState createState() => _ContestantDetailsPageState();
}

class _ContestantDetailsPageState extends State<ContestantDetailsPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    ));
    // initialize the controller with the video id
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.snippet?.resourceId?.videoId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  double walletBalance = 0;
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
  bool isupdatingBalance = false;

  TextEditingController _voteCountController = TextEditingController(text: '1');
  Future<void> _voteForContestant(int voteCount) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _getWalletBalance();
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
              title: Text("Vote Recorded!"),
              content: Text(
                  "You've voted successfully.\nWallet balance is now $updatedWalletBalance."),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.topCenter,
            colors: [
              Colors.transparent,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                // replace the image with the youtube player
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                        EdgeInsets.symmetric(horizontal : 16, vertical : 8),
                        child : Stack(
                          children:[
                            Positioned.fill(
                              child : Container(
                                decoration : BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient : LinearGradient(
                                        begin : Alignment.bottomCenter,
                                        end : Alignment.topCenter,
                                        colors : [
                                          Colors.white,
                                          Colors.blue,
                                        ]
                                    )
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Card(
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.network(
                                    widget.video.snippet!.thumbnails!.default_!.url!,
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width : 8),
                                Flexible(
                                  child : Text(
                                    widget.video.snippet!.title!,
                                    style : TextStyle(fontSize : 25, color : Colors.black, fontFamily :
                                    'Poppins',
                                      fontWeight :
                                      FontWeight.w700,),
                                    textAlign : TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.symmetric(horizontal : 16, vertical : 8),
                        child : Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          children:[
                            Text('Description', style : TextStyle(color : Colors.black, fontFamily :
                            'Poppins',
                                fontWeight :
                                FontWeight.w700,
                                fontSize :
                                20),),
                            Text(widget.video.snippet!.description!, style : TextStyle(fontSize : 15, color : Colors.blue, fontFamily :
                            'Poppins',
                              fontWeight :
                              FontWeight.w200,),),
                          ],
                        ),
                      ),
                      SizedBox(height : 16),
                      if(isupdatingBalance)
                        SpinKitThreeInOut(color: Colors.yellow),
                      ElevatedButton.icon(
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
                                            _voteForContestant( voteCount);
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
                      ),// remove the watch video button
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
