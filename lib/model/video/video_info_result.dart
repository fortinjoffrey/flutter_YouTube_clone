import 'package:flutter/material.dart';

class VideoInfoResult {
  final String author;
  final String timestamp;
  final String viewCount;
  final String likeCount;
  final String dislikeCount;
  final String description;

  VideoInfoResult({
    @required this.author,
    @required this.timestamp,
    @required this.viewCount,
    @required this.likeCount,
    @required this.dislikeCount,
    @required this.description,
  });

  factory VideoInfoResult.fromMap(Map<String, dynamic> map) {
    return VideoInfoResult(
      author: map['snippet']['channelTitle'],
      timestamp: map['snippet']['publishedAt'],
      viewCount: map['statistics']['viewCount'],
      likeCount: map['statistics']['likeCount'],
      dislikeCount: map['statistics']['dislikeCount'],
      description: map['snippet']['description'],
    );
  }
}
