import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/channel/channel_info_result.dart';
import '../model/channel/channel_result.dart';
import '../model/search_result.dart';
import '../model/video/video_result.dart';
import '../shared/keys.dart';

class YoutubeAPIService {
  YoutubeAPIService._instantiate();

  static final YoutubeAPIService instance = YoutubeAPIService._instantiate();
  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<List<SearchResult>> fetchSearchResults(String searchText,
      {@required bool isNewSearch}) async {
    List<SearchResult> results = List<SearchResult>();
    _nextPageToken = isNewSearch ? '' : _nextPageToken;

    Map<String, String> urlParams = {
      'part': 'snippet',
      'q': searchText,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };

    final response = await _fetchResponseFrom(urlParams, 'youtube/v3/search');

    if (response != null) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      print('_nextPageToken = $_nextPageToken');

      List<dynamic> items = data['items'];

      items.forEach((item) async {
        final String kind = item['id']['kind'];

        switch (kind) {
          case 'youtube#channel':
            ChannelResult channel = ChannelResult.fromMap(item);
            ChannelInfoResult channelInfo = await _fetchChannelInfo(channel.id);

            channel.subscriberCount = channelInfo.subscriberCount;
            channel.videoCount = channelInfo.videoCount;
            channel.hiddenSubscriberCount = channelInfo.hiddenSubscriberCount;

            results.add(channel);
            break;
          case 'youtube#video':
            VideoResult video = VideoResult.fromMap(item);
            results.add(video);
            break;
          default:
        }
      });
    }
    print(results.length);
    return results;
  }

  Future<ChannelInfoResult> _fetchChannelInfo(String channelId) async {
    Map<String, String> urlParams = {
      'part': 'statistics',
      'id': channelId,
      'key': API_KEY,
    };

    final response =
        await _fetchResponseFrom(urlParams, '/youtube/v3/channels');

    if (response != null) {
      var data = json.decode(response.body);

      return ChannelInfoResult.fromMap(data['items'][0]);
    } else {
      return ChannelInfoResult(
          subscriberCount: '', videoCount: '', hiddenSubscriberCount: false);
    }
  }

  Future<http.Response> _fetchResponseFrom(
      Map<String, String> urlParams, String urlSection) async {
    Uri uri = Uri.https(_baseUrl, urlSection, urlParams);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final response = await http.get(uri, headers: headers);

    if (200 == response.statusCode) {
      return response;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
