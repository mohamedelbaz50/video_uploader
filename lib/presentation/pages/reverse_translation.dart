import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/presentation/pages/data.dart';

class ReverseTranslation extends StatefulWidget {
  const ReverseTranslation({super.key});

  @override
  State<ReverseTranslation> createState() => _ReverseTranslationState();
}

class _ReverseTranslationState extends State<ReverseTranslation> {
  final TextEditingController _searchController = TextEditingController();

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    loadVideoPlayer('');
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
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: _searchController,
                    onSubmitted: (value) {
                      String criteria = value.replaceAll(" ", "").toLowerCase();
                      loadVideoPlayer(criteria);
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        letterSpacing: 1.5,
                      ),
                      hintText: 'Value',
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
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
