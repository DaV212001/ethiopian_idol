import 'package:ethiopian_idol/components/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/main.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowCard extends StatefulWidget {
  ShowCard({
    required this.height,
    required this.width,
    this.onpressed,
    required this.link,
    required this.isVotecard,
    required this.category,
  });

  final double height;
  final double width;
  final String link;
  final bool isVotecard;
  final String category;
  final void Function()? onpressed;

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
                          Text(
                              category == 'Singing'
                                  ? 'Abebe Kebe'
                                  : category == 'Dancing'
                                  ? 'Kebede Abe'
                                  : category == 'Comedy'
                                  ? 'Shemsu Sol'
                                  : 'Biniam Bo',
                              style: TextStyle(
                                  color:
                                  themeProvider.selectedTheme ==
                                      'dark'
                                      ? Colors.black
                                      : Colors.black,
                                  fontFamily: 'Outfit-black',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15)),
                          Text('12.6k votes',
                              style: TextStyle(
                                  color:
                                  themeProvider.selectedTheme ==
                                      'dark'
                                      ? Colors.black
                                      : Colors.black,
                                  fontFamily: 'Outfit-black',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15))
                        ],
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                themeProvider.selectedTheme ==
                                    'dark'
                                    ? Colors.black
                                    : Colors.white),
                            shape:
                            MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(25.0),
                              ),
                            ),
                            padding:
                            MaterialStateProperty.all<
                                EdgeInsetsGeometry>(
                                EdgeInsets.all(10)),
                            overlayColor:
                            MaterialStateProperty.all<Color>(
                                Colors.blue.shade100)),
                        onPressed:<VoidCallback>(){},
                        child:
                        Icon(Icons.thumb_up_alt_rounded, color:
                        Colors.green, size:
                        20,),
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
