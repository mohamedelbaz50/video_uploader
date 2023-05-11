import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';

import '../../core/themes/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  InkWell(
                    child: Icon(Icons.abc),
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickVideo(source: ImageSource.camera);
                      if (pickedFile != null) {
                        final videoPlayerController =
                            VideoPlayerController.file(File(pickedFile.path));
                        await videoPlayerController.initialize();
                        setState(() {
                          controller = videoPlayerController;
                        });
                      }
                    },
                  )
                ],
                title: const Text("My Videos"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                  ),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        cubit.videoPlay();
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_library,
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            Text(cubit.pickedVideo!.path.split('/').last),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      label: "My Videos", icon: Icon(Icons.video_camera_back)),
                  BottomNavigationBarItem(
                      label: "About us", icon: Icon(Icons.info)),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
              ),
              floatingActionButton: SpeedDial(
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
                      label: "From Gallery",
                      child: const Icon(Icons.video_collection)),
                  SpeedDialChild(
                      onTap: () {
                        cubit.getVideoFromCamera();
                      },
                      backgroundColor: MyColors.lightGreen,
                      foregroundColor: Colors.white,
                      label: "take Video",
                      child: const Icon(Icons.camera_enhance))
                ],
              ));
        },
      ),
    );
  }

  Widget offsetPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text(
              "Flutter Open",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Flutter Tutorial",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      );
}
