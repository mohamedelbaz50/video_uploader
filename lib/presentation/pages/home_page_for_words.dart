import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';
import 'package:video_uploader/presentation/pages/dialog.dart';

import '../../core/themes/colors.dart';

class HomePageForWords extends StatelessWidget {
  HomePageForWords({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return state is PlayVideoState
              ? Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        cubit.controller.dispose();
                        cubit.restartApp();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  body: FlickVideoPlayer(flickManager: cubit.flickManager))
              : Scaffold(
                  appBar: AppBar(
                    actions: [
                      state is GetDataLoadingState
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyColors.lightGreen,
                              ),
                            )
                          : Container()
                    ],
                    title: Text(
                      "فيديوهاتى",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemCount: cubit.videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              cubit.videoPlay(index: index);
                            },
                            child: Card(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.video_library,
                                      size: 50,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        cubit.videos[index].path
                                            .split('/')
                                            .last,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    const SizedBox(height: 10),
                                    ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    MyColors.lightPurple)),
                                        onPressed: () {
                                          cubit
                                              .uploadVideo(index: index)
                                              .then((value) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        DialogBuild(
                                                          text: cubit.maxString,
                                                          state: state,
                                                        ));
                                          });
                                        },
                                        icon: const Icon(Icons.search),
                                        label: const Text("ترجم"))
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SpeedDial(
                      backgroundColor: MyColors.lightPurple,
                      icon: Icons.add_a_photo,
                      activeIcon: Icons.close,
                      children: [
                        SpeedDialChild(
                            onTap: () {
                              cubit.getVideoFromGallery();
                            },
                            backgroundColor: MyColors.lightPurple,
                            foregroundColor: Colors.white,
                            labelStyle: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            label: "من المعرض",
                            child: const Icon(Icons.video_collection)),
                        SpeedDialChild(
                            onTap: () {
                              cubit.getVideoFromCamera();
                            },
                            backgroundColor: MyColors.lightPurple,
                            foregroundColor: Colors.white,
                            labelStyle: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            label: "التقط فيديو",
                            child: const Icon(Icons.camera_enhance))
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}
