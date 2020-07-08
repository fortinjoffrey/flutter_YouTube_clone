import 'package:flutter/material.dart';

class ChannelInfoResult {
  final String subscriberCount;
  final String videoCount;
  final bool hiddenSubscriberCount;

  ChannelInfoResult({
    @required this.subscriberCount,
    @required this.videoCount,
    @required this.hiddenSubscriberCount,
  });

  factory ChannelInfoResult.fromMap(Map<String, dynamic> map) {
    return ChannelInfoResult(
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      hiddenSubscriberCount: map['statistics']['hiddenSubscriberCount'],
    );
  }
}
