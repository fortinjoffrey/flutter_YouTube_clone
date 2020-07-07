import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            color: index % 2 == 0 ? Colors.red : Colors.blue,
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
