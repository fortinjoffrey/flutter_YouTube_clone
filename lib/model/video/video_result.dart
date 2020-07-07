import '../search_result.dart';

class VideoResult extends SearchResult {
  VideoResult({
    id,
    kind,
    title,
    thumbnailUrl,
  }) : super(id, kind, title, thumbnailUrl);

  factory VideoResult.fromMap(Map<String, dynamic> map) {
    return VideoResult(
      id: map['id']['videoId'],
      kind: map['id']['kind'],
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['medium']['url'],
    );
  }
}
