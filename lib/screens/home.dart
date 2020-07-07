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
            onSubmitted: (searchText) async {
              List<SearchResult> fetchedResults = await YoutubeAPIService
                  .instance
                  .fetchSearchResults(searchText);
              setState(() {
                results = fetchedResults;
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
}
