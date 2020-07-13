import 'package:flutter/material.dart';
import 'package:youtube_api_clone/extensions/string_extension.dart';
import 'package:youtube_api_clone/model/video/video_result.dart';
import 'package:intl/intl.dart';

class VideoCell extends StatelessWidget {
  const VideoCell({Key key, this.video}) : super(key: key);

  final VideoResult video;

  @override
  Widget build(BuildContext context) {
    print(video.title);
    print(video.minInfo.timestamp);
    final String viewCount = NumberFormat.compact(locale: 'en-EN')
        .format(double.parse(video.minInfo.viewCount));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Image(
              image: NetworkImage(video.thumbnailUrl),
            ),
          ),
          SizedBox(width: 16.0),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  video.minInfo.author,
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '${StringExtension.displayTimeAgoFromTimestamp(video.minInfo.timestamp)} - $viewCount views',
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
