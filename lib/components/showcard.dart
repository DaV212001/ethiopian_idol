import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/main.dart';

class ShowCard extends StatelessWidget {
  ShowCard({required this.height, required this.width, this.onpressed, required this.link, required this.isVotecard});
  final double height;
  final double width;
  late final String link;
  final bool isVotecard;

  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onpressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: isVotecard == false
            ? Container(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(link, fit: BoxFit.fill),
          ),
        )

            : Column(
            children: [
              Card(
                color: themeProvider.selectedTheme=='dark'?Colors.blue:Colors.white,
                shadowColor: Colors.lightBlueAccent,
                elevation: 10,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      height: height,
                      width: width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(link, fit: BoxFit.fill),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Abebe Kebe', style:
                            TextStyle(color:
                            Colors.grey.shade800, fontFamily:
                            'Outfit-black', fontWeight:
                            FontWeight.w600, fontSize:
                            15)),
                            Text('12.6k votes', style:
                            TextStyle(color:
                            Colors.grey.shade800, fontFamily:
                            'Outfit-black', fontWeight:
                            FontWeight.w400, fontSize:
                            15))
                          ],),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:MaterialStateProperty.all<Color>(themeProvider.selectedTheme=='dark'?Colors.blue:Colors.white),
                                shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(25.0),
                              ),
                            ),

                                padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(10)),

                                overlayColor:
                                MaterialStateProperty.all<Color>(Colors.blue.shade100)
                            ),
                            onPressed:<VoidCallback>(){},
                            child:
                            Icon(
                              Icons.thumb_up_alt_rounded,
                              color:
                              Colors.greenAccent,
                              size:
                              20,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
