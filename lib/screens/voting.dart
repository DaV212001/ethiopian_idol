import 'package:flutter/material.dart';
import 'package:ethiopian_idol/components/showcard.dart';
import 'package:ethiopian_idol/components/constants.dart';
import 'package:flutter/services.dart';
import 'package:ethiopian_idol/screens/categorieslistview.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';

class Voting extends StatefulWidget {
  const Voting({Key? key}) : super(key: key);

  @override
  State<Voting> createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  String? selectedCategory = 'Music';

  List<DropdownMenuItem<String>> getDropdownitems() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (int i = 0; i < categoriesList.length; i++) {
      String category = categoriesList[i];
      var newitem = DropdownMenuItem(
        child: Text(
          category,
          style: TextStyle(
            fontFamily: 'Outfit-black',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        value: category,
      );
      dropdownitems.add(newitem);
    }
    return dropdownitems;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: themeProvider.selectedTheme == 'dark' ?Brightness.light:Brightness.dark),
        backgroundColor: themeProvider.selectedTheme == 'dark' ?Colors.black:Colors.white,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 36, left: 8, right: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text('Vote',
                      style: TextStyle(
                          color: themeProvider.selectedTheme == 'dark' ?Colors.white:Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor:
      themeProvider.selectedTheme == 'dark' ?Colors.black:Colors.white, // Set the background color to match your app's color scheme
      body:
      Column(
        children:[
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: Row(
              children:[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                    decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.lightBlueAccent,
                    ),
                    child:
                    Icon(Icons.candlestick_chart_rounded, size: 40,),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child:
                  SingleChildScrollView(
                    scrollDirection:
                    Axis.horizontal,
                    child:
                    Row(children:[
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                          margin: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightBlueAccent,
                          ),
                          child:
                      Row(children:[
                        Icon(Icons.music_note, size: 30),
                        Text('Singing'),
                      ]))),
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                          margin: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightBlueAccent,
                          ),
                          child:
                      Row(children:[
                        Icon(Icons.music_note, size: 30),
                        Text('Dancing'),
                      ]))),
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                          margin: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightBlueAccent,
                          ),
                          child:
                      Row(children:[
                        Icon(Icons.theater_comedy, size: 30),
                        Text('Comedy'),
                      ]))),
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.lightBlueAccent,
                        ),

                          child:
                      Row(children:[
                        Icon(Icons.star_border_purple500_rounded, size: 30),
                        Text('Magic'),
                      ]))),
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                          margin: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightBlueAccent,
                          ),
                          child:
                      Row(children:[
                        Icon(Icons.theater_comedy, size: 30),
                        Text('Acting'),
                      ]))),
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                          margin: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightBlueAccent,
                          ),
                          child:
                      Row(children:[
                        Icon(Icons.create, size: 30),
                        Text('Poetry'),
                      ]))),
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                          margin: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightBlueAccent,
                          ),
                          child:
                      Row(children:[
                        Icon(Icons.multitrack_audio_sharp, size: 30),
                        Text('Instruments'),
                      ]))),
                      InkWell(onTap:
                          () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => CategoriesList()));
                      }, child:
                      Container(
                          margin: EdgeInsets.all(5),
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightBlueAccent,
                          ),
                          child:
                      Row(children:[
                        Icon(Icons.theater_comedy, size: 30),
                        Text('Impersonation'),
                      ]))),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
            Padding(
              padding: EdgeInsets.only(left: 3, right: 3, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: ShowCard(
                                  height: 150,
                                  width: double.infinity,
                                  link: 'https://th.bing.com/th/id/OIP.a6z_dtdJOGTCv9fqvvItfgHaFj?pid=ImgDet&rs=1',
                                  isVotecard: true,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: ShowCard(
                                  height: 150,
                                  width: double.infinity,
                                  link: 'https://th.bing.com/th/id/OIP.a6z_dtdJOGTCv9fqvvItfgHaFj?pid=ImgDet&rs=1',
                                  isVotecard: true,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    ;
  }
}
