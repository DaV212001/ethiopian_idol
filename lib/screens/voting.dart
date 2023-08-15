import 'package:flutter/material.dart';
import 'package:ethiopian_idol/components/showcard.dart';
import 'package:ethiopian_idol/components/constants.dart';

class Voting extends StatefulWidget {
  const Voting({Key? key}) : super(key: key);

  @override
  State<Voting> createState() => _VotingState();
}

class _VotingState extends State<Voting>  {

  String? selectedCategory = 'Music';
  List<DropdownMenuItem<String>> getDropdownitems() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (int i = 0; i < categoriesList.length; i++) {
      String category = categoriesList[i];
      var newitem = DropdownMenuItem(
        child: Text(category),
        value: category,
      );
      dropdownitems.add(newitem);
    }
    return dropdownitems;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Vote for your favorite Contestant', style :
              TextStyle(color :
              Colors.grey.shade800, fontFamily :
              'Outfit-black', fontWeight :
              FontWeight.w700, fontSize :
              15)),
              Container(
                height: 70.0,
                alignment: Alignment.center,
                color: Colors.white,
                child: DropdownButton<String>(
                    value: selectedCategory,
                    items: getDropdownitems(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
              ListView.builder(scrollDirection:
              Axis.vertical, itemCount:
              10, itemBuilder:(context, index) {
                return ShowCard(height:
                200, width:
                150, link :
                'https://picsum.photos/200', isVotecard :
                true);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
