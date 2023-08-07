import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:video_uploader/presentation/cubit/app_cubit.dart';
import 'package:video_uploader/presentation/cubit/app_states.dart';

import '../../core/themes/colors.dart';
import 'dialog.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
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
            title: Text("أرسل الفيديو للاختبار"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
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
                                  Text(cubit.videos[index].path.split('/').last,
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
                                              builder: (BuildContext context) =>
                                                  DialogBuild(
                                                    text: cubit.maxString ==
                                                            label
                                                        ? "أحسنت\n اجابه صحيحه"
                                                        : "خطأ \n حاول مجددا",
                                                    state: state,
                                                  ));
                                        });
                                      },
                                      icon: const Icon(Icons.search),
                                      label: const Text("ارسال"))
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              ],
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
                    labelStyle:
                        const TextStyle(fontSize: 18, color: Colors.black),
                    label: "من المعرض",
                    child: const Icon(Icons.video_collection)),
                SpeedDialChild(
                    onTap: () {
                      cubit.getVideoFromCamera();
                    },
                    backgroundColor: MyColors.lightPurple,
                    foregroundColor: Colors.white,
                    labelStyle:
                        const TextStyle(fontSize: 18, color: Colors.black),
                    label: "التقط فيديو",
                    child: const Icon(Icons.camera_enhance))
              ],
            ),
          ),
        );
      },
    );
  }
}
