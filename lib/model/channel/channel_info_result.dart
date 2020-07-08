import 'package:flutter/material.dart';

class ChannelInfoResult {
  final String subscriberCount;
  final String videoCount;

  ChannelInfoResult({
    @required this.subscriberCount,
    @required this.videoCount,
  });

  factory ChannelInfoResult.fromMap(Map<String, dynamic> map) {
    return ChannelInfoResult(
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
    );
  }
}
