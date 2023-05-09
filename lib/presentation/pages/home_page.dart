import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:video_uploader/core/themes/colors.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                title: const Text("My Videos"),
              ),
              body: Column(
                children: [],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      label: "My Videos", icon: Icon(Icons.video_camera_back)),
                  BottomNavigationBarItem(
                      label: "About us", icon: Icon(Icons.info)),
                ],
                currentIndex: 0,
                onTap: (value) {},
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
