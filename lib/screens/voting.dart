import 'package:ethiopian_idol/components/categorymodel.dart';
import 'package:ethiopian_idol/screens/voting.dart';
import 'package:flutter/material.dart';
import 'package:ethiopian_idol/components/showcard.dart';
import 'package:ethiopian_idol/components/constants.dart';
import 'package:flutter/services.dart';
import 'package:ethiopian_idol/screens/categorieslistview.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';

 String cate= 'Singing';

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
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Colors.white,
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
      themeProvider.selectedTheme == 'dark' ?Color(0xFF121212):Colors.white, // Set the background color to match your app's color scheme
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
                      color: themeProvider.selectedTheme == 'dark' ? Color(0xFFFFFD00) :Colors.yellow,
                    ),
                    child:
                    Icon(Icons.candlestick_chart_rounded, size: 40, color: themeProvider.selectedTheme == 'dark'? Colors.black:Colors.black),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child:
                  CategoryScrollable(themeProvider: themeProvider),
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
                      itemCount: 11,
                      itemBuilder: (context, index) {
                        if (index == 10) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10, top: 50),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
                            child: Text('Powered by Micro Sun Technologies', style:
                            TextStyle(color:
                            themeProvider.selectedTheme == 'dark' ?Colors.yellow:Colors.black, fontFamily:
                            'Poppins', fontWeight:
                            FontWeight.w200, fontSize:
                            15)),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ShowCard(
                                      height: 150,
                                      width: double.infinity,
                                      link:
                                      'https://th.bing.com/th/id/OIP.a6z_dtdJOGTCv9fqvvItfgHaFj?pid=ImgDet&rs=1',
                                      isVotecard: true,
                                      category: cate),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: ShowCard(
                                      height: 150,
                                      width: double.infinity,
                                      link:
                                      'https://th.bing.com/th/id/OIP.a6z_dtdJOGTCv9fqvvItfgHaFj?pid=ImgDet&rs=1',
                                      isVotecard: true,
                                      category: cate),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )

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

class CategoryScrollable extends StatelessWidget {
  const CategoryScrollable({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    // Define a list of maps that contains the data for each category
    final categories = [
      {'icon': Icons.music_note, 'text': 'Singing'},
      {'icon': Icons.music_note, 'text': 'Dancing'},
      {'icon': Icons.theater_comedy, 'text': 'Comedy'},
      {'icon': Icons.star_border_purple500_rounded, 'text': 'Magic'},
      {'icon': Icons.theater_comedy, 'text': 'Acting'},
      {'icon': Icons.create, 'text': 'Poetry'},
      {'icon': Icons.multitrack_audio_sharp, 'text': 'Instruments'},
      {'icon': Icons.theater_comedy, 'text': 'Impersonation'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Use a for loop to generate the InkWell widgets
          for (var category in categories)
            InkWell(
              onTap: () {
                Provider.of<CategoryModel>(context, listen: false)
                    .selectCategory(category['text'] as String);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:
                  themeProvider.selectedTheme == 'dark' ? Color(0xFFFFFD00) : Colors.yellow,
                ),
                child: Row(
                  children: [
                    Icon(category['icon'] as IconData,
                        size: 30,
                        color:
                        themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black),
                    Text(
                      category['text'] as String,
                      style: TextStyle(
                          color:
                          themeProvider.selectedTheme == 'dark' ? Colors.black : Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200
                      ),

                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}