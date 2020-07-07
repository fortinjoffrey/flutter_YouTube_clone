import 'package:flutter/material.dart';
import 'package:youtube_api_clone/model/channel/channel_result.dart';
import 'package:youtube_api_clone/model/search_result.dart';
import 'package:youtube_api_clone/model/video/video_result.dart';
import 'package:youtube_api_clone/views/channel_cell.dart';
import 'package:youtube_api_clone/views/video_cell.dart';
import '../shared/constants.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<SearchResult> results = dummyResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          _buildSearchTextField(),
          Expanded(
            child: _buildSearchResultsListView(),
          ),
        ],
      ),
    );
  }

  ListView _buildSearchResultsListView() {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        SearchResult result = results[index];

        if (result is ChannelResult) {
          return ChannelCell(channel: result);
        } else if (result is VideoResult) {
          return VideoCell(video: result);
        } else {
          return Text('Error');
        }
      },
    );
  }

  TextField _buildSearchTextField() {
    return TextField(
      autocorrect: false,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
          contentPadding: const EdgeInsets.all(16.0),
          hintText: 'Search for channel or video'),
    );
  }
}
