import '../search_result.dart';

class ChannelResult extends SearchResult {
  final String subscriberCount;
  final String videoCount;

  ChannelResult({
    id,
    kind,
    title,
    thumbnailUrl,
    this.subscriberCount,
    this.videoCount,
  }) : super(id, kind, title, thumbnailUrl);

  ChannelResult.dummy(
    id,
    kind,
    title,
    thumbnailUrl,
    this.subscriberCount,
    this.videoCount,
  ) : super(id, kind, title, thumbnailUrl);
}
