import 'package:youtube_api_clone/model/channel/channel_info_result.dart';

import '../search_result.dart';

class ChannelResult extends SearchResult {
  ChannelInfoResult minInfo;

  ChannelResult({
    id,
    kind,
    title,
    thumbnailUrl,
    minInfo,
  }) : super(id, kind, title, thumbnailUrl);

  factory ChannelResult.fromMap(Map<String, dynamic> map) {
    return ChannelResult(
      id: map['id']['channelId'],
      kind: map['id']['kind'],
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['default']['url'],
    );
  }
}
