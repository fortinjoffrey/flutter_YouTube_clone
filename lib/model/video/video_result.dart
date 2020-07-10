import 'package:youtube_api_clone/model/video/video_info_result.dart';

import '../search_result.dart';

class VideoResult extends SearchResult {
  VideoInfoResult minInfo;

  VideoResult({
    id,
    kind,
    title,
    thumbnailUrl,
    minInfo,
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
