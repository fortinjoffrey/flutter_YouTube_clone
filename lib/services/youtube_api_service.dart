import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_api_clone/model/video/video_info_result.dart';

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

      await Future.forEach(items, (item) async {
        final String kind = item['id']['kind'];

        switch (kind) {
          case 'youtube#channel':
            ChannelResult channel = ChannelResult.fromMap(item);
            ChannelInfoResult channelInfo = await _fetchChannelInfo(channel.id);
            channel.minInfo = channelInfo;
            results.add(channel);
            break;
          case 'youtube#video':
            VideoResult video = VideoResult.fromMap(item);
            VideoInfoResult videoInfo = await _fetchVideoInfo(video.id);
            video.minInfo = videoInfo;
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

  Future<VideoInfoResult> _fetchVideoInfo(String videoId) async {
    Map<String, String> urlParams = {
      'part': 'snippet, statistics',
      'id': videoId,
      'key': API_KEY,
    };

    final response = await _fetchResponseFrom(urlParams, '/youtube/v3/videos');

    if (response != null) {
      var data = json.decode(response.body);

      return VideoInfoResult.fromMap(data['items'][0]);
    } else {
      return VideoInfoResult(author: '', timestamp: '', viewCount: '');
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

/*
 
 Future<Video> _fetchVideoInfoFromId({String videoId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, statistics',
      'id': videoId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(_baseUrl, 'youtube/v3/videos', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);

    if (200 == response.statusCode) {
      var data = json.decode(response.body);

      dynamic videoJson = data['items'][0];

      return Video.fromMap(videoJson);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

 */
