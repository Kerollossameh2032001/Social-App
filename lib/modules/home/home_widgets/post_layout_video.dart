import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class PostVideoLayout extends StatefulWidget {
  final String? videoUrl;

  const PostVideoLayout({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _PostVideoLayoutState createState() => _PostVideoLayoutState();
}

class _PostVideoLayoutState extends State<PostVideoLayout> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl!)
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
