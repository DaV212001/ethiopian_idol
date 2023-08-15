import 'package:flutter/material.dart';
import 'package:ethiopian_idol/components/showcard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child:
                      Image.asset('images/ethiopianidolslogo.png')),
                  const SizedBox(width: 10),
                  Text(
                    'Ethiopian Idol',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontFamily: 'Outfit-black',
                        fontWeight: FontWeight.w900,
                        fontSize: 30),
                  ),
                ],
              ),
              const CircleAvatar(
                child: Text('U'),
              ),
            ],
          ),
        ),
        body:
        SingleChildScrollView(child:
        Column(crossAxisAlignment:
        CrossAxisAlignment.start, children:[
          const Padding(padding:
          EdgeInsets.all(16.0), child:
          TextField(decoration:
          InputDecoration(hintText:
          'Find Event', icon:
          Icon(Icons.search), border:
          OutlineInputBorder(borderRadius:
          BorderRadius.all(Radius.circular(40)))))),
          Padding(padding:
          EdgeInsets.all(30.0), child:
          Text('Popular Contestants', style:
          TextStyle(color:
          Colors.grey.shade800, fontFamily:
          'Outfit-black', fontWeight:
          FontWeight.w700, fontSize:
          25))),
          Container(height:
          200, child:
          ListView.builder(scrollDirection:
          Axis.horizontal, itemCount:
          10, itemBuilder:(context, index) {
            return ShowCard(height:
            200, width:
            150, link :
            'https://picsum.photos/200', isVotecard :
            false);
          })),
          Padding(padding :
          EdgeInsets.all(30), child :
          Text('Register as a Contestant', style :
          TextStyle(color :
          Colors.grey.shade800, fontFamily :
          'Outfit-black', fontWeight :
          FontWeight.w700, fontSize :
          25))),
          Card(shape :
          RoundedRectangleBorder(borderRadius :
          BorderRadius.circular(20)), child :
          Column(children:[
            Container(height :
            200, decoration :
            BoxDecoration(borderRadius :
            BorderRadius.circular(20)), child :
            Image.network('https://picsum.photos/200', fit :
            BoxFit.cover)),
            TextButton(onPressed:<VoidCallback>
                () {}, child :
            const Text('Register')),
          ])),
        ])),
      ),
    );
  }
}
