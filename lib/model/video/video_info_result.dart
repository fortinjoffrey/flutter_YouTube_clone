import 'package:flutter/material.dart';

class VideoInfoResult {
  final String author;
  final String timestamp;
  final String viewCount;

  VideoInfoResult({
    @required this.author,
    @required this.timestamp,
    @required this.viewCount,
  });

  factory VideoInfoResult.fromMap(Map<String, dynamic> map) {
    return VideoInfoResult(
      author: map['snippet']['channelTitle'],
      timestamp: map['snippet']['publishedAt'],
      viewCount: map['statistics']['viewCount'],
    );
  }
}
