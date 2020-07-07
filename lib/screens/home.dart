import 'package:flutter/material.dart';
import 'package:youtube_api_clone/model/channel/channel_result.dart';
import 'package:youtube_api_clone/model/search_result.dart';
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

        return Container(
          height: 100,
          decoration: BoxDecoration(
            color: result is ChannelResult ? Colors.red : Colors.blue,
          ),
          child: Center(
            child: Text(results[index].title),
          ),
        );
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
