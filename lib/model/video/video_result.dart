import '../search_result.dart';

class VideoResult extends SearchResult {
  VideoResult({
    id,
    kind,
    title,
    thumbnailUrl,
  }) : super(id, kind, title, thumbnailUrl);

  VideoResult.dummy(
    id,
    kind,
    title,
    thumbnailUrl,
  ) : super(id, kind, title, thumbnailUrl);
}
