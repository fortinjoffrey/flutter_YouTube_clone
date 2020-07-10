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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            YoutubePlayer(
              controller: _playerController,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready');
              },
            ),
            SizedBox(height: 16.0),
            _buildTitleAndViewCount(),
            SizedBox(height: 16.0),
            Divider(height: 0.0, color: Colors.black12),
            SizedBox(height: 8.0),
            _buildActionsButtonsRow(),
            SizedBox(height: 8.0),
            Divider(height: 0.0, color: Colors.black12),
            SizedBox(height: 16.0),
            _buildDescriptionContainer(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Container _buildTitleAndViewCount() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  video.title,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text("${video.minInfo.viewCount} views"),
        ],
      ),
    );
  }

  Container _buildDescriptionContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Text('video.description'),
    );
  }

  Row _buildActionsButtonsRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.thumb_up),
              ),
              SizedBox(height: 8.0),
              Container(
                child: Text("${int.parse('31')}"),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.thumb_down),
              ),
              SizedBox(height: 8.0),
              Container(
                child: Text("${int.parse('31')}"),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.share),
              ),
              SizedBox(height: 8.0),
              Container(
                child: Text("Share"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
