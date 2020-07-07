import 'package:youtube_api_clone/model/channel/channel_result.dart';
import 'package:youtube_api_clone/model/search_result.dart';
import 'package:youtube_api_clone/model/video/video_result.dart';

List<SearchResult> dummyResults = [
  ChannelResult.dummy(
      'id', 'kind', 'channel title1', 'thumbnailUrl', '30', '40'),
  VideoResult.dummy('id', 'kind', 'video title1', 'thumbnailUrl'),
  ChannelResult.dummy(
      'id', 'kind', 'channel title2', 'thumbnailUrl', '30', '40'),
];
