import '../search_result.dart';

class ChannelResult extends SearchResult {
  String subscriberCount;
  String videoCount;

  ChannelResult({
    id,
    kind,
    title,
    thumbnailUrl,
    this.subscriberCount,
    this.videoCount,
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
