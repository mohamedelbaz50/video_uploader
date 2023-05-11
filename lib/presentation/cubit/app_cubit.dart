import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  File? pickedVideo;
  List<File> videos = [];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  final ImagePicker picker = ImagePicker();
  Future<void> getVideoFromGallery() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedVideo = File(pickedFile.path);
      videos.add(pickedVideo!);
      print(videos.length);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(VideoPickedFromGalleryState());
    } else {
      if (kDebugMode) {
        print('No Video selected.');
      }
      emit((VideoNotPickedFromGalleryState()));
    }
  }

  Future<void> getVideoFromCamera() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      pickedVideo = File(pickedFile.path);
      videos.add(pickedVideo!);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(VideoPickedFromGalleryState());
    } else {
      if (kDebugMode) {
        print('No Video selected.');
      }
      emit((VideoNotPickedFromGalleryState()));
    }
  }

  late VideoPlayerController controller;

  Future videoPlay() async {
    final videoPlayerController = VideoPlayerController.file(pickedVideo!);
    await videoPlayerController.initialize().then((value) {
      controller = videoPlayerController;
      controller.play();
      emit(PlayVideoState());
    });
  }
}
