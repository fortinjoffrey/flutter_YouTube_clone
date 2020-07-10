import 'package:flutter/material.dart';
import 'package:youtube_api_clone/model/channel/channel_result.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({Key key, this.channel}) : super(key: key);

  final ChannelResult channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(channel.title),
      ),
      body: Container(
        child: Center(child: Text('coucou')),
      ),
    );
  }
}
