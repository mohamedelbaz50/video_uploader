import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/core/cache_helper.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';
import 'package:video_uploader/presentation/pages/about_us_page.dart';
import 'package:video_uploader/presentation/pages/home_page_for_words.dart';
import 'package:video_uploader/presentation/pages/reverse_translation.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  File? pickedVideo;
  File? pickedImage;

  List<File> videos = [];
  List<Widget> bottomNavPages = [
    HomePageForWords(),
    const ReverseTranslation(),
    const AboutUsPage()
  ];
  ImagePicker picker = ImagePicker();
  late VideoPlayerController controller;
  late FlickManager flickManager;

  double maxDouble = double.negativeInfinity;

  String maxString = "";
  Map<String, double> doubleMap = {};

  Dio dio = Dio();

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  bool isDark = false;
  changTheme({fromShared}) {
    if (fromShared != null) {
      isDark = fromShared!;
    } else {
      isDark = !isDark;
    }

    CacheHelper.setData(key: "isDark", value: isDark).then((value) {
      emit(ChangeThemeState());
    });
  }

  bool langValue = true;
  changeLang(value) {
    langValue = value;
    emit(ChangeLangState());
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

  Future<void> getVideoFromGallery() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
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

  void restartApp() {
    emit(AppInitialState());
  }

  Future uploadVideo({required int index}) async {
    emit(GetDataLoadingState());
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(videos[index].path),
      });

      final Response response = await dio.post(
        "http://10.0.2.2:8000/prediction/word",
        options: Options(
            contentType: 'application/json',
            sendTimeout: const Duration(seconds: 20)),
        data: formData,
      );
      if (response.statusCode == 200) {
        response.data.forEach((key, value) {
          doubleMap[key] = double.parse(value);
        });
        doubleMap.forEach((key, value) {
          if (value > maxDouble) {
            maxDouble = value;
            maxString = key;
          }
        });
        print(maxString);

        emit(GetDataSuccessState());
      } else {
        emit(GetDataErrorState());
      }
    } catch (error) {
      print(error);
    }
  }

  Future videoPlay({required int index}) async {
    final videoPlayerController = VideoPlayerController.file(videos[index]);
    await videoPlayerController.initialize().then((value) {
      controller = videoPlayerController;
      flickManager = FlickManager(videoPlayerController: videoPlayerController);
      controller.play();
      emit(PlayVideoState());
    });
  }

  List<File> images = [];

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      images.add(pickedImage!);
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

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      images.add(pickedImage!);
      if (kDebugMode) {
        print(images);
      }
      emit(VideoPickedFromGalleryState());
    } else {
      if (kDebugMode) {
        print('No Video selected.');
      }
      emit((VideoNotPickedFromGalleryState()));
    }
  }

  Map<String, dynamic> value = {};
  uploadImageForNumber({required int index}) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(images[index].path),
      });
      final Response response = await dio.post(
        "http://10.0.2.2:8000/prediction/number",
        options: Options(
            contentType: 'application/json',
            sendTimeout: const Duration(seconds: 10)),
        data: formData,
      );
      value = response.data;
    } catch (error) {
      print(error);
    }
  }

  uploadImageForChar({required int index}) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(images[index].path),
      });
      final Response response = await dio.post(
        "http://10.0.2.2:8000/prediction/alphabet",
        options: Options(
            contentType: 'application/json',
            sendTimeout: const Duration(seconds: 20)),
        data: formData,
      );
      print(response);
      value = response.data;
    } catch (error) {
      print(error);
    }
  }
}
