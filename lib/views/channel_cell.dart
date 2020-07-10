import 'package:flutter/material.dart';
import 'package:youtube_api_clone/model/channel/channel_result.dart';

class ChannelCell extends StatelessWidget {
  const ChannelCell({Key key, this.channel}) : super(key: key);

  final ChannelResult channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Center(
              child: CircleAvatar(
                radius: 45.0,
                backgroundImage: NetworkImage(channel.thumbnailUrl),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  channel.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  channel.minInfo.hiddenSubscriberCount
                      ? '${channel.minInfo.videoCount} videos'
                      : '${channel.minInfo.subscriberCount} subscribers - ${channel.minInfo.videoCount} videos',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'SUBSCRIBE',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
