import 'package:flutter/material.dart';
import 'package:ethiopian_idol/main.dart';

class Judge {
  final String name;
  final String imageUrl;
  final String bio;

  Judge({
    required this.name,
    required this.imageUrl,
    required this.bio,
  });
}

class JudgeDetailsPage extends StatelessWidget {
  final Judge judge;

  const JudgeDetailsPage({
    Key? key,
    required this.judge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: [
            SingleChildScrollView(
              child:
              Padding(
                padding: EdgeInsets.zero,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(judge.imageUrl),
                    Text(
                        'About',
                        style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 25)
                    ),
                    SizedBox(height: 8.0),
                    Text(judge.bio, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w200, fontSize: 15),),
                  ],
                ),
              ),

            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),

                        child: IconButton(

                          iconSize: 50,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.chevron_left),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),

                          child: Center(
                            child: Text(
                              judge.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        )

    );
  }
}