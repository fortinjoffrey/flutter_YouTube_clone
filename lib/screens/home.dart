import 'package:flutter/material.dart';

import '../model/channel/channel_result.dart';
import '../model/search_result.dart';
import '../model/video/video_result.dart';
import '../services/youtube_api_service.dart';
import '../views/channel_cell.dart';
import '../views/video_cell.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SearchResult> results = List<SearchResult>();
  bool _isLoading = false;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          // ignore: todo
          // TODO: extract TextField (will do when implementing state management)
          TextField(
            autocorrect: false,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              contentPadding: const EdgeInsets.all(16.0),
              hintText: 'Search for channel or video',
            ),
            onSubmitted: (text) async {
              setState(() {
                _isLoading = true;
                _searchText = text;
              });
              List<SearchResult> fetchedResults = await YoutubeAPIService
                  .instance
                  .fetchSearchResults(_searchText, isNewSearch: true);
              setState(() {
                results = fetchedResults;
                _isLoading = false;
              });
            },
          ),
          Expanded(
            child: _buildSearchResultsListView(),
          ),
        ],
      ),
    );
  }

  NotificationListener<ScrollNotification> _buildSearchResultsListView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollDetails) {
        if (!_isLoading &&
            scrollDetails.metrics.pixels + 50 >=
                scrollDetails.metrics.maxScrollExtent) {
          _fetchMoreResults();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: _isLoading ? results.length + 1 : results.length,
        itemBuilder: (context, index) {
          if (_isLoading) {
            if (index == results.length) {
              return _buildCircularProgressIndicator();
            }
          }

          SearchResult result = results[index];

          if (result is ChannelResult) {
            return ChannelCell(channel: result);
          } else if (result is VideoResult) {
            return VideoCell(video: result);
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }

  Container _buildCircularProgressIndicator() {
    return Container(
      height: 100,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _fetchMoreResults() async {
    setState(() {
      _isLoading = true;
    });

    List<SearchResult> newResults = await YoutubeAPIService.instance
        .fetchSearchResults(_searchText, isNewSearch: false);

    setState(() {
      results = results..addAll(newResults);
      _isLoading = false;
    });
  }
}
