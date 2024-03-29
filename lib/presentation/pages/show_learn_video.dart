import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/presentation/pages/data.dart';

class ShowLearnVideo extends StatefulWidget {
  final String word;
  const ShowLearnVideo({super.key, required this.word});

  @override
  State<ShowLearnVideo> createState() => _ShowLearnVideoState();
}

class _ShowLearnVideoState extends State<ShowLearnVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    loadVideoPlayer(this.widget.word);
  }

  loadVideoPlayer(String word) {
    controller = VideoPlayerController.asset(data[word] ?? '');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                  Text("Total Duration: ${controller.value.duration}"),
                  VideoProgressIndicator(controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        backgroundColor: Colors.redAccent,
                        playedColor: Colors.green,
                        bufferedColor: Colors.purple,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (controller.value.isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }

                            setState(() {});
                          },
                          icon: Icon(controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow)),
                      IconButton(
                          onPressed: () {
                            controller.seekTo(const Duration(seconds: 0));

                            setState(() {});
                          },
                          icon: const Icon(Icons.stop))
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
