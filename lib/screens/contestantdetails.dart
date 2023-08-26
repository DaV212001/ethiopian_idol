import 'package:ethiopian_idol/main.dart';
import 'package:ethiopian_idol/screens/contestantdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/connectors/v1.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hero_animation/hero_animation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:ethiopian_idol/screens/youtubeplayer.dart';

class ContestantDetailsPage extends StatefulWidget {
  final PlaylistItem video;

  const ContestantDetailsPage({Key? key, required this.video}) : super(key: key);

  @override
  _ContestantDetailsPageState createState() => _ContestantDetailsPageState();
}

class _ContestantDetailsPageState extends State<ContestantDetailsPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    ));
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
                Image.network(widget.video.snippet!.thumbnails!.high!.url!),
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
                      Center(
                        child: ElevatedButton(
                          onPressed: widget.video.snippet?.resourceId?.videoId == null
                              ? null
                              : () async {
                            var videoId = widget.video.snippet?.resourceId?.videoId;
                            if (videoId != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YoutubePlayerPage(videoId: videoId),
                                ),
                              );
                            }
                          },
                          child: Text(widget.video.snippet?.resourceId?.videoId == null
                              ? 'Video Not Available'
                              : 'Watch Video'),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
