import 'package:flutter/material.dart';
import 'package:youtube_api_clone/model/video/video_result.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen(this.video, {Key key}) : super(key: key);

  final VideoResult video;

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _playerController = YoutubePlayerController(
      initialVideoId: video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            YoutubePlayer(
              controller: _playerController,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready');
              },
            ),
          ],
        ),
      ),
    );
  }
}
