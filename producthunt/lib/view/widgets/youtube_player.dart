import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'image_preview.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String video_id;
  final String thumbnailUrl;
  YoutubePlayerWidget({required this.video_id, required this.thumbnailUrl});
  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Get.height * 0.03, horizontal: 10),
      child: YoutubePlayerBuilder(
          player: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: widget.video_id,
                flags: const YoutubePlayerFlags(
                  hideControls: false,
                  controlsVisibleAtStart: true,
                  disableDragSeek: true,
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              thumbnail: ImagePreViewWidget(
                imageUrl: widget.thumbnailUrl,
              ),
          ),
          builder: (context, player) {
            return player;
          }),
    );
  }
}
