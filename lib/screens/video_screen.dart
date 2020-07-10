import 'package:flutter/material.dart';
import 'package:youtube_api_clone/model/video/video_result.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key key, this.video}) : super(key: key);

  final VideoResult video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
      ),
      body: Container(
        child: Center(child: Text('coucou')),
      ),
    );
  }
}
