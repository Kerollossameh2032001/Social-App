import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoItem extends StatefulWidget {
  final File? video;

  const VideoItem({Key? key, required this.video}) : super(key: key);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video!)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white.withOpacity(0.1),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
