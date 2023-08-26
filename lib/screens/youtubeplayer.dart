import 'package:flutter/material.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubePlayerPage extends StatefulWidget {
  final String videoId;

  YoutubePlayerPage({required this.videoId});

  @override
  _YoutubePlayerPageState createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController _controller;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.white,
      appBar: AppBar(
        backgroundColor:themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Colors.transparent,
        title: Text('Ethiopian Idol', style: TextStyle(color:  themeProvider.selectedTheme == 'dark' ?Color(0xFFFFFD00) : Colors.grey.shade800,fontFamily: 'Poppins', fontWeight: FontWeight.w700),),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
      ),
    );
  }
}