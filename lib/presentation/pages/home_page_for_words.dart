import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';
import 'package:video_uploader/presentation/pages/about_us_page.dart';
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
                        cubit.currentIndex == 0 ? "فيديوهاتى" : "تعرف علينا"),
                  ),
                  body: cubit.currentIndex == 0
                      ? Padding(
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                          ),
                                          const SizedBox(height: 10),
                                          ElevatedButton.icon(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          MyColors.lightGreen)),
                                              onPressed: () {
                                                cubit
                                                    .uploadVideo(index: index)
                                                    .then((value) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          DialogBuild(
                                                            text:
                                                                cubit.maxString,
                                                            state: state,
                                                          ));
                                                });
                                              },
                                              icon: const Icon(Icons.search),
                                              label: const Text("تنبأ"))
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        )
                      : const AboutUsPage(),
                  bottomNavigationBar: BottomNavigationBar(
                    items: const [
                      BottomNavigationBarItem(
                          label: "فيديوهاتى",
                          icon: Icon(Icons.video_camera_back)),
                      BottomNavigationBarItem(
                          label: "تعرف علينا", icon: Icon(Icons.info)),
                    ],
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.changeBottomNav(index);
                    },
                  ),
                  floatingActionButton: cubit.currentIndex == 0
                      ? SpeedDial(
                          backgroundColor: MyColors.lightGreen,
                          icon: Icons.add_a_photo,
                          activeIcon: Icons.close,
                          children: [
                            SpeedDialChild(
                                onTap: () {
                                  cubit.getVideoFromGallery();
                                },
                                backgroundColor: MyColors.lightGreen,
                                foregroundColor: Colors.white,
                                label: "من المعرض",
                                child: const Icon(Icons.video_collection)),
                            SpeedDialChild(
                                onTap: () {
                                  cubit.getVideoFromCamera();
                                },
                                backgroundColor: MyColors.lightGreen,
                                foregroundColor: Colors.white,
                                label: "التقط فيديو",
                                child: const Icon(Icons.camera_enhance))
                          ],
                        )
                      : null);
        },
      ),
    );
  }
}
