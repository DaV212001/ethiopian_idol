import 'package:flutter/material.dart';


class ShowCard extends StatelessWidget {
  ShowCard({required this.height, required this.width, this.onpressed, required this.link, required this.isVotecard});
  final double height;
  final double width;
  late final String link;
  final bool isVotecard;


  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onpressed,
      child: Card(shape:
      RoundedRectangleBorder(borderRadius:
      BorderRadius.circular(20)), child:
      isVotecard==false?
      Container(width:
      width, height:
      height, decoration:
      BoxDecoration(
          borderRadius:
          BorderRadius.circular(50)), child:
      Image.network(link, fit:
      BoxFit.cover)
      )
          :

      Column(children:[
        Container(height:
        200, decoration:
        BoxDecoration(borderRadius:
        BorderRadius.circular(20)), child:
        Image.network('https://picsum.photos/200', fit:
        BoxFit.cover)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed:<VoidCallback>
                () {}, child:
            Icon(Icons.thumb_up_alt_rounded, color: Colors.green,)
            ),
            TextButton(onPressed:<VoidCallback>
                () {}, child:
            Icon(Icons.thumb_down_alt_rounded, color: Colors.red,)
            )
          ],
        ),
      ])
      ),
    );
  }
}